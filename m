Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5316A76FCBD
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 11:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRqgA-0003J4-Io; Fri, 04 Aug 2023 05:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qRqg9-0003Ig-94
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:01:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qRqg4-0004bs-QB
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:01:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1EAA62186F;
 Fri,  4 Aug 2023 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691139654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NrO5aR9LGa1iPAtbydJGLHdtiRAjjOQXU7g7odZpDs=;
 b=M1lpuv/ndTRQzMzYA0hjyQ/hsVnuJkJ4UjmqrXQsS3eaxOvNXu/noBKvFUgQh2ABR2+6sf
 KFAu41arZ4FFNzbQqYe6ZyWMrxdsRNPSbtyq2Aofg5qyd1KQdJsDmYoRMeO1nILTTWsTUN
 xZ/wN5OyXgogi/cueLTzg+dxR4nj1zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691139654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NrO5aR9LGa1iPAtbydJGLHdtiRAjjOQXU7g7odZpDs=;
 b=O4rjXEJXewVWQHaHXsTdGFl8adW3vuynQF0HkqqdcMsAPbnh1Y4eM1zTjrnR3t7sdl+XI3
 cgIN9tpdeKV6e2BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFD81133B5;
 Fri,  4 Aug 2023 09:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1r7mOEW+zGQpCgAAMHmgww
 (envelope-from <cfontana@suse.de>); Fri, 04 Aug 2023 09:00:53 +0000
Message-ID: <c97ae743-1f8e-d61e-adae-75d930db988e@suse.de>
Date: Fri, 4 Aug 2023 11:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Issue with s390 TCG and libc __strstr_arch13 [Was: Re: assert fails
 in s390x TCG]
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
To: Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
In-Reply-To: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi,

On 7/21/23 11:08, Claudio Fontana wrote:
> 
> Hello Cornelia, Richard,
> 
> I had some strange behavior in an s390x TCG VM that I am debugging,
> 
> and configured latest upstream QEMU with --enable-debug --enable-debug-tcg
> 
> and I am running the qemu binary with -d unimp,guest_errors .
> 
> I get:
> 
> /usr/bin/qemu-system-s390x -nodefaults -no-reboot -nographic -vga none -cpu qemu -d unimp,guest_errors -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-ccw,rng=rng0 -runas qemu -net none -kernel /var/tmp/boot/kernel -initrd /var/tmp/boot/initrd -append root=/dev/disk/by-id/virtio-0 rootfstype=ext3 rootflags=data=writeback,nobarrier,commit=150,noatime elevator=noop nmi_watchdog=0 rw oops=panic panic=1 quiet elevator=noop console=hvc0 init=build -m 2048 -drive file=/var/tmp/img,format=raw,if=none,id=disk,cache=unsafe -device virtio-blk-ccw,drive=disk,serial=0 -drive file=/var/tmp/swap,format=raw,if=none,id=swap,cache=unsafe -device virtio-blk-ccw,drive=swap,serial=1 -device virtio-serial-ccw -device virtconsole,chardev=virtiocon0 -chardev stdio,id=virtiocon0 -chardev socket,id=monitor,server=on,wait=off,path=/var/tmp/img.qemu/monitor -mon chardev=monitor,mode=readline -smp 8
> 
> unimplemented opcode 0xb9ab
> unimplemented opcode 0xb2af
> 

...

> Since I have some strange misbehavior at runtime, with processes dying with segfaults and the guest kernel complaining:
> 
>  [ 2269s] [ 2243.901667][ T8318] User process fault: interruption code 0011 ilc:2 in libc.so.6[3ff87a80000+1c9000]
>  [ 2269s] [ 2243.904433][ T8318] Failing address: 000002aa0f73f000 TEID: 000002aa0f73f800
>  [ 2269s] [ 2243.904952][ T8318] Fault in primary space mode while using user ASCE.
>  [ 2269s] [ 2243.905405][ T8318] AS:00000000057841c7 R3:0000000001fdc007 S:000000000398c000 P:0000000000000400 
> 

I am analyzing this problem further, now that the assertions have been solved.

I seem to have found an issue that manifests as a wrong return value from glibc's

__strstr_arch13

found in glibc/sysdeps/s390/strstr-arch13.S, which ends up in libc.so

Based on my tests, I could not trigger this issue on baremetal, I could only see it when run under TCG.

The workload here is the testsuite of the swig package:

git clone https://github.com/swig/swig.git

https://github.com/swig/swig/releases/tag/v4.1.1
https://github.com/swig/swig/commit/77323a0f07562b7d90d36181697a72a909b9519a

The error presents itself as a return of strstr with a match past the end of the terminating NUL character of the string.

Here is the test I am doing to showcase it: I implemented a simple strstr as follows:

--------

static char *strstr_simple(const char *haystack, const char *needle)
{
  /*                                                                                                                                        
   * This function return a pointer to the beginning of the located substring, or NULL if the substring is not found.                       
   * If needle is the empty string, the return value is always haystack itself.                                                             
   */
  int i, j;

  if (needle == NULL || haystack == NULL) {
    return NULL;
  }
  if (needle[0] == 0) {
    return (char *)haystack;
  }
  for (i = 0; haystack[i] != 0; i++) {
    for (j = 0; haystack[i + j] != 0 && needle[j] != 0; j++) {
      if (needle[j] != haystack[i + j]) {
        break;
      }
    }
    if (needle[j] == 0) {
      return (char *)haystack + i;
    }
  }
  return NULL;
}


--------

and then I have a wrapper that compares the results of this simple implementation with what comes from regular strstr,
where I made sure that the strstr_ifunc results in __strstr_arch13:

char *strstr_w(const char *haystack, const char *needle)
{
  char *rv1 = strstr(haystack, needle);
  char *rv2 = strstr_simple(haystack, needle);
  if (rv1 != rv2) {
    printf("haystack: %p \"%s\"\n"
           "needle: %p \"%s\"\n"
           "rv1: %p\n"
           "rv2: %p\n",
           (void*)haystack, haystack,
           (void*)needle, needle,
           (void*)rv1, (void*)rv2);
    assert(0);
  }
  return rv1;
}

--------


After building swig with compilation flags: -m64 -march=z14 -mtune=z15

and running even a minimal test like:

$ cd Examples/perl5/simple
$ export SWIG_LIB=../../../Lib
$ ../../../swig -perl5 -o example.c.wrap example.i

I get:

haystack: 0x2aa2a2488f0 "        "363:operator< ignored" "
needle: 0x2aa2961bc8c " ^A"
rv1: 0x2aa2a24891e
rv2: (nil)
swig: DOH/copy.c:120: strstr_w: Assertion `0' failed.
Aborted

As you can see here strstr returns a match where there is none, and what is even worse, the pointer 0x2aa2a24891e is past the end of the string (0x2aa2a248910).

This causes the successive code (that relies on valid strstr results) to memmove a negative value of bytes, which ends up hitting the end of the heap for the process, causing the segfault originally encountered.

I can make the issue disappear for example by forcing the strstr_ifunc to choose __GI_strstr instead of __strstr_arch13.

Maybe something going wrong in the vector string search emulation, something rings a bell?

Let me know if there is something I can provide that could help investigate further.

Thanks,

Claudio










