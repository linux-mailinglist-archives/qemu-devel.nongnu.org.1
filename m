Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54E76FD23
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 11:22:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRqzd-000190-Oi; Fri, 04 Aug 2023 05:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRqzb-00018e-TW
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRqzZ-000236-Ci
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691140864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8TJKFqE6SJmTVv3lXgK/3Mjwlej+GEeiUOT308ip9k=;
 b=PbWL0DoNIVlUt9HsFkUzcewylcHrWIv7lO+bhGg4fXd2+MK/vSTKBHfGJJPFhyY7sk/V0B
 Ylyu7k8eIq24BMY5pnETxcfL8ay8fTkVXQHoF5kIZlHKe/YqaT4ghoyi/oYt8zPmb8vMvo
 Lb9E9DR/vjWuzb4XUxAagzpn/J9y1VM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-081fxlROPniasslIH7kQdQ-1; Fri, 04 Aug 2023 05:21:00 -0400
X-MC-Unique: 081fxlROPniasslIH7kQdQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40fe31e76d4so23334021cf.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 02:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691140860; x=1691745660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u8TJKFqE6SJmTVv3lXgK/3Mjwlej+GEeiUOT308ip9k=;
 b=f6tqtes2By2ae3H4dbBqU+2aFD56XPJMBuRNmslttpayCYTwSZpVdrddpUvWfeASZB
 S14BdVhECk6jwCoeeBug0k1j/t0nmV34s5ZnnWKRg+uKloPUnwzpbgCqrqwUacJ8cpGc
 ZnxRRN9Sd3cGcYg1EpyfsksWcAEOYstNQQb96ZNGRXZ4YOjCl4aBeJ2wOzUKyEM90yG8
 9my3DVjJ4oU8CNJ6ElHEWRNKS02f15W0hzxf7VH+roOhCUSgwRpUiV2y6nvqdhx8qeJQ
 9I7jTfTpWRbocwY/8FAnbRH9CYUU6hY9tKmYXAmAU3b64gHzvx7HtwnGGmS1hml+i567
 vejg==
X-Gm-Message-State: AOJu0YyE1SwZlUGtY2dBANMfAPTI/H3D0UqzOWn/cN0MyaAvhAmDypsz
 6uLdHay/UcmKOvSk3BaIvwD6M2tNA1XFAY0949+TfDiXQJW6QLeQ9eK8TTIZA7H2rWHRHnq6LIf
 MH5Yz/nwpoJMiu/8=
X-Received: by 2002:a05:622a:4d:b0:407:30b8:5f58 with SMTP id
 y13-20020a05622a004d00b0040730b85f58mr1681116qtw.61.1691140860428; 
 Fri, 04 Aug 2023 02:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDPyTQ7561IK6RIA5G8DFlhHkJJsuUK6MwXioglPVCP3yvqg+hEaZjtD9KLU0dXdXFxphKUg==
X-Received: by 2002:a05:622a:4d:b0:407:30b8:5f58 with SMTP id
 y13-20020a05622a004d00b0040730b85f58mr1681100qtw.61.1691140860147; 
 Fri, 04 Aug 2023 02:21:00 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-187.web.vodafone.de.
 [109.43.176.187]) by smtp.gmail.com with ESMTPSA id
 w26-20020a05622a191a00b0040ff2a9ca0asm512280qtc.67.2023.08.04.02.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 02:20:59 -0700 (PDT)
Message-ID: <9af11a13-4cb4-9f86-db8c-755b57063fed@redhat.com>
Date: Fri, 4 Aug 2023 11:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Issue with s390 TCG and libc __strstr_arch13
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <c97ae743-1f8e-d61e-adae-75d930db988e@suse.de>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <c97ae743-1f8e-d61e-adae-75d930db988e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 04/08/2023 11.00, Claudio Fontana wrote:
> Hi,
> 
> On 7/21/23 11:08, Claudio Fontana wrote:
>>
>> Hello Cornelia, Richard,
>>
>> I had some strange behavior in an s390x TCG VM that I am debugging,
>>
>> and configured latest upstream QEMU with --enable-debug --enable-debug-tcg
>>
>> and I am running the qemu binary with -d unimp,guest_errors .
>>
>> I get:
>>
>> /usr/bin/qemu-system-s390x -nodefaults -no-reboot -nographic -vga none -cpu qemu -d unimp,guest_errors -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-ccw,rng=rng0 -runas qemu -net none -kernel /var/tmp/boot/kernel -initrd /var/tmp/boot/initrd -append root=/dev/disk/by-id/virtio-0 rootfstype=ext3 rootflags=data=writeback,nobarrier,commit=150,noatime elevator=noop nmi_watchdog=0 rw oops=panic panic=1 quiet elevator=noop console=hvc0 init=build -m 2048 -drive file=/var/tmp/img,format=raw,if=none,id=disk,cache=unsafe -device virtio-blk-ccw,drive=disk,serial=0 -drive file=/var/tmp/swap,format=raw,if=none,id=swap,cache=unsafe -device virtio-blk-ccw,drive=swap,serial=1 -device virtio-serial-ccw -device virtconsole,chardev=virtiocon0 -chardev stdio,id=virtiocon0 -chardev socket,id=monitor,server=on,wait=off,path=/var/tmp/img.qemu/monitor -mon chardev=monitor,mode=readline -smp 8
>>
>> unimplemented opcode 0xb9ab
>> unimplemented opcode 0xb2af
>>
> 
> ...
> 
>> Since I have some strange misbehavior at runtime, with processes dying with segfaults and the guest kernel complaining:
>>
>>   [ 2269s] [ 2243.901667][ T8318] User process fault: interruption code 0011 ilc:2 in libc.so.6[3ff87a80000+1c9000]
>>   [ 2269s] [ 2243.904433][ T8318] Failing address: 000002aa0f73f000 TEID: 000002aa0f73f800
>>   [ 2269s] [ 2243.904952][ T8318] Fault in primary space mode while using user ASCE.
>>   [ 2269s] [ 2243.905405][ T8318] AS:00000000057841c7 R3:0000000001fdc007 S:000000000398c000 P:0000000000000400
>>
> 
> I am analyzing this problem further, now that the assertions have been solved.
> 
> I seem to have found an issue that manifests as a wrong return value from glibc's
> 
> __strstr_arch13
> 
> found in glibc/sysdeps/s390/strstr-arch13.S, which ends up in libc.so
> 
> Based on my tests, I could not trigger this issue on baremetal, I could only see it when run under TCG.
> 
> The workload here is the testsuite of the swig package:
> 
> git clone https://github.com/swig/swig.git
> 
> https://github.com/swig/swig/releases/tag/v4.1.1
> https://github.com/swig/swig/commit/77323a0f07562b7d90d36181697a72a909b9519a
> 
> The error presents itself as a return of strstr with a match past the end of the terminating NUL character of the string.
> 
> Here is the test I am doing to showcase it: I implemented a simple strstr as follows:
> 
> --------
> 
> static char *strstr_simple(const char *haystack, const char *needle)
> {
>    /*
>     * This function return a pointer to the beginning of the located substring, or NULL if the substring is not found.
>     * If needle is the empty string, the return value is always haystack itself.
>     */
>    int i, j;
> 
>    if (needle == NULL || haystack == NULL) {
>      return NULL;
>    }
>    if (needle[0] == 0) {
>      return (char *)haystack;
>    }
>    for (i = 0; haystack[i] != 0; i++) {
>      for (j = 0; haystack[i + j] != 0 && needle[j] != 0; j++) {
>        if (needle[j] != haystack[i + j]) {
>          break;
>        }
>      }
>      if (needle[j] == 0) {
>        return (char *)haystack + i;
>      }
>    }
>    return NULL;
> }
> 
> 
> --------
> 
> and then I have a wrapper that compares the results of this simple implementation with what comes from regular strstr,
> where I made sure that the strstr_ifunc results in __strstr_arch13:
> 
> char *strstr_w(const char *haystack, const char *needle)
> {
>    char *rv1 = strstr(haystack, needle);
>    char *rv2 = strstr_simple(haystack, needle);
>    if (rv1 != rv2) {
>      printf("haystack: %p \"%s\"\n"
>             "needle: %p \"%s\"\n"
>             "rv1: %p\n"
>             "rv2: %p\n",
>             (void*)haystack, haystack,
>             (void*)needle, needle,
>             (void*)rv1, (void*)rv2);
>      assert(0);
>    }
>    return rv1;
> }
> 
> --------
> 
> 
> After building swig with compilation flags: -m64 -march=z14 -mtune=z15
> 
> and running even a minimal test like:
> 
> $ cd Examples/perl5/simple
> $ export SWIG_LIB=../../../Lib
> $ ../../../swig -perl5 -o example.c.wrap example.i
> 
> I get:
> 
> haystack: 0x2aa2a2488f0 "        "363:operator< ignored" "
> needle: 0x2aa2961bc8c " ^A"
> rv1: 0x2aa2a24891e
> rv2: (nil)
> swig: DOH/copy.c:120: strstr_w: Assertion `0' failed.
> Aborted
> 
> As you can see here strstr returns a match where there is none, and what is even worse, the pointer 0x2aa2a24891e is past the end of the string (0x2aa2a248910).
> 
> This causes the successive code (that relies on valid strstr results) to memmove a negative value of bytes, which ends up hitting the end of the heap for the process, causing the segfault originally encountered.
> 
> I can make the issue disappear for example by forcing the strstr_ifunc to choose __GI_strstr instead of __strstr_arch13.
> 
> Maybe something going wrong in the vector string search emulation, something rings a bell?
> 
> Let me know if there is something I can provide that could help investigate further.

Could you maybe get a disassembly of your __strstr_arch13 function, so we 
could see which vector instructions are in there?

  Thomas


