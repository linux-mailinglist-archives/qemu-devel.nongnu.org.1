Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11076FDF3
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 11:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrZa-00059T-0H; Fri, 04 Aug 2023 05:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qRrZY-00058x-CG; Fri, 04 Aug 2023 05:58:16 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qRrZW-0007Sb-7K; Fri, 04 Aug 2023 05:58:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8848A21864;
 Fri,  4 Aug 2023 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691143092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlfVY2uVv36OnWE8vSKB+JDAY20DEaZX8jAXhcrcWCg=;
 b=SJYitfeYq3DXqP/s4QdXe2E1b2g5+1qcbnjoL31TRcJqNmLxZii0hz0Ka6qZhBOZw8LSme
 RnXGzhHLen0XKV7BVzDFSq8nFoF0Kxiz34V8IM6Aa0PJjhNvbbt+zKM04w0dh/5gnEKlrK
 ZOLVfvscUvTzdD9ALOcWgJo17voGgKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691143092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlfVY2uVv36OnWE8vSKB+JDAY20DEaZX8jAXhcrcWCg=;
 b=MIIyWYfDHxp1vDFQkfO1Stb92O2drRU3v7tIJayQrK9Bbpek5/gg37dhqaCZ/M0mx7sSj1
 OFEhmOHuoCWXaCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FB6913904;
 Fri,  4 Aug 2023 09:58:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DM75EbTLzGQiJgAAMHmgww
 (envelope-from <cfontana@suse.de>); Fri, 04 Aug 2023 09:58:12 +0000
Message-ID: <629b26f2-ffb7-7a6c-6a21-a60cfba700b9@suse.de>
Date: Fri, 4 Aug 2023 11:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Issue with s390 TCG and libc __strstr_arch13
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <c97ae743-1f8e-d61e-adae-75d930db988e@suse.de>
 <9af11a13-4cb4-9f86-db8c-755b57063fed@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <9af11a13-4cb4-9f86-db8c-755b57063fed@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/4/23 11:20, Thomas Huth wrote:
> On 04/08/2023 11.00, Claudio Fontana wrote:
>> Hi,
>>
>> On 7/21/23 11:08, Claudio Fontana wrote:
>>>
>>> Hello Cornelia, Richard,
>>>
>>> I had some strange behavior in an s390x TCG VM that I am debugging,
>>>
>>> and configured latest upstream QEMU with --enable-debug --enable-debug-tcg
>>>
>>> and I am running the qemu binary with -d unimp,guest_errors .
>>>
>>> I get:
>>>
>>> /usr/bin/qemu-system-s390x -nodefaults -no-reboot -nographic -vga none -cpu qemu -d unimp,guest_errors -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-ccw,rng=rng0 -runas qemu -net none -kernel /var/tmp/boot/kernel -initrd /var/tmp/boot/initrd -append root=/dev/disk/by-id/virtio-0 rootfstype=ext3 rootflags=data=writeback,nobarrier,commit=150,noatime elevator=noop nmi_watchdog=0 rw oops=panic panic=1 quiet elevator=noop console=hvc0 init=build -m 2048 -drive file=/var/tmp/img,format=raw,if=none,id=disk,cache=unsafe -device virtio-blk-ccw,drive=disk,serial=0 -drive file=/var/tmp/swap,format=raw,if=none,id=swap,cache=unsafe -device virtio-blk-ccw,drive=swap,serial=1 -device virtio-serial-ccw -device virtconsole,chardev=virtiocon0 -chardev stdio,id=virtiocon0 -chardev socket,id=monitor,server=on,wait=off,path=/var/tmp/img.qemu/monitor -mon chardev=monitor,mode=readline -smp 8
>>>
>>> unimplemented opcode 0xb9ab
>>> unimplemented opcode 0xb2af
>>>
>>
>> ...
>>
>>> Since I have some strange misbehavior at runtime, with processes dying with segfaults and the guest kernel complaining:
>>>
>>>   [ 2269s] [ 2243.901667][ T8318] User process fault: interruption code 0011 ilc:2 in libc.so.6[3ff87a80000+1c9000]
>>>   [ 2269s] [ 2243.904433][ T8318] Failing address: 000002aa0f73f000 TEID: 000002aa0f73f800
>>>   [ 2269s] [ 2243.904952][ T8318] Fault in primary space mode while using user ASCE.
>>>   [ 2269s] [ 2243.905405][ T8318] AS:00000000057841c7 R3:0000000001fdc007 S:000000000398c000 P:0000000000000400
>>>
>>
>> I am analyzing this problem further, now that the assertions have been solved.
>>
>> I seem to have found an issue that manifests as a wrong return value from glibc's
>>
>> __strstr_arch13
>>
>> found in glibc/sysdeps/s390/strstr-arch13.S, which ends up in libc.so
>>
>> Based on my tests, I could not trigger this issue on baremetal, I could only see it when run under TCG.
>>
>> The workload here is the testsuite of the swig package:
>>
>> git clone https://github.com/swig/swig.git
>>
>> https://github.com/swig/swig/releases/tag/v4.1.1
>> https://github.com/swig/swig/commit/77323a0f07562b7d90d36181697a72a909b9519a
>>
>> The error presents itself as a return of strstr with a match past the end of the terminating NUL character of the string.
>>
>> Here is the test I am doing to showcase it: I implemented a simple strstr as follows:
>>
>> --------
>>
>> static char *strstr_simple(const char *haystack, const char *needle)
>> {
>>    /*
>>     * This function return a pointer to the beginning of the located substring, or NULL if the substring is not found.
>>     * If needle is the empty string, the return value is always haystack itself.
>>     */
>>    int i, j;
>>
>>    if (needle == NULL || haystack == NULL) {
>>      return NULL;
>>    }
>>    if (needle[0] == 0) {
>>      return (char *)haystack;
>>    }
>>    for (i = 0; haystack[i] != 0; i++) {
>>      for (j = 0; haystack[i + j] != 0 && needle[j] != 0; j++) {
>>        if (needle[j] != haystack[i + j]) {
>>          break;
>>        }
>>      }
>>      if (needle[j] == 0) {
>>        return (char *)haystack + i;
>>      }
>>    }
>>    return NULL;
>> }
>>
>>
>> --------
>>
>> and then I have a wrapper that compares the results of this simple implementation with what comes from regular strstr,
>> where I made sure that the strstr_ifunc results in __strstr_arch13:
>>
>> char *strstr_w(const char *haystack, const char *needle)
>> {
>>    char *rv1 = strstr(haystack, needle);
>>    char *rv2 = strstr_simple(haystack, needle);
>>    if (rv1 != rv2) {
>>      printf("haystack: %p \"%s\"\n"
>>             "needle: %p \"%s\"\n"
>>             "rv1: %p\n"
>>             "rv2: %p\n",
>>             (void*)haystack, haystack,
>>             (void*)needle, needle,
>>             (void*)rv1, (void*)rv2);
>>      assert(0);
>>    }
>>    return rv1;
>> }
>>
>> --------
>>
>>
>> After building swig with compilation flags: -m64 -march=z14 -mtune=z15
>>
>> and running even a minimal test like:
>>
>> $ cd Examples/perl5/simple
>> $ export SWIG_LIB=../../../Lib
>> $ ../../../swig -perl5 -o example.c.wrap example.i
>>
>> I get:
>>
>> haystack: 0x2aa2a2488f0 "        "363:operator< ignored" "
>> needle: 0x2aa2961bc8c " ^A"
>> rv1: 0x2aa2a24891e
>> rv2: (nil)
>> swig: DOH/copy.c:120: strstr_w: Assertion `0' failed.
>> Aborted
>>
>> As you can see here strstr returns a match where there is none, and what is even worse, the pointer 0x2aa2a24891e is past the end of the string (0x2aa2a248910).
>>
>> This causes the successive code (that relies on valid strstr results) to memmove a negative value of bytes, which ends up hitting the end of the heap for the process, causing the segfault originally encountered.
>>
>> I can make the issue disappear for example by forcing the strstr_ifunc to choose __GI_strstr instead of __strstr_arch13.
>>
>> Maybe something going wrong in the vector string search emulation, something rings a bell?
>>
>> Let me know if there is something I can provide that could help investigate further.
> 
> Could you maybe get a disassembly of your __strstr_arch13 function, so we 
> could see which vector instructions are in there?
> 
>   Thomas

Here it is:

000000000002ac70 <__strstr_arch13>:
   2ac70:	e7 10 30 00 60 27 	lcbb	%r1,0(%r3),6
   2ac76:	a7 14 00 c6       	jo	2ae02 <__strstr_arch13+0x192>
   2ac7a:	e7 20 30 00 68 06 	vl	%v18,0(%r3),6
   2ac80:	e7 32 20 20 0e 81 	vfenezb	%v19,%v18,%v18
   2ac86:	e7 43 00 07 04 21 	vlgvb	%r4,%v19,7
   2ac8c:	a7 59 00 11       	lghi	%r5,17
   2ac90:	ec 48 e0 00 00 fc 	cgibe	%r4,0,0(%r14)
   2ac96:	c2 4e 00 00 00 09 	clgfi	%r4,9
   2ac9c:	c0 24 00 04 70 42 	jgh	b8d20 <__GI_strstr>
   2aca2:	b9 09 00 54       	sgr	%r5,%r4
   2aca6:	e7 10 20 00 60 27 	lcbb	%r1,0(%r2),6
   2acac:	a7 14 00 96       	jo	2add8 <__strstr_arch13+0x168>
   2acb0:	e7 00 20 00 08 06 	vl	%v16,0(%r2)
   2acb6:	e7 40 20 20 3f 8b 	vstrszb	%v20,%v16,%v18,%v19
   2acbc:	a7 74 00 33       	jne	2ad22 <__strstr_arch13+0xb2>
   2acc0:	e7 10 20 10 60 27 	lcbb	%r1,16(%r2),6
   2acc6:	a7 14 00 87       	jo	2add4 <__strstr_arch13+0x164>
   2acca:	e7 00 20 10 08 06 	vl	%v16,16(%r2)
   2acd0:	e7 40 20 20 3f 8b 	vstrszb	%v20,%v16,%v18,%v19
   2acd6:	a7 74 00 24       	jne	2ad1e <__strstr_arch13+0xae>
   2acda:	e7 10 20 20 60 27 	lcbb	%r1,32(%r2),6
   2ace0:	a7 14 00 78       	jo	2add0 <__strstr_arch13+0x160>
   2ace4:	e7 00 20 20 08 06 	vl	%v16,32(%r2)
   2acea:	e7 40 20 20 3f 8b 	vstrszb	%v20,%v16,%v18,%v19
   2acf0:	a7 74 00 15       	jne	2ad1a <__strstr_arch13+0xaa>
   2acf4:	e7 10 20 30 60 27 	lcbb	%r1,48(%r2),6
   2acfa:	a7 14 00 69       	jo	2adcc <__strstr_arch13+0x15c>
   2acfe:	e7 00 20 30 08 06 	vl	%v16,48(%r2)
   2ad04:	e7 40 20 20 3f 8b 	vstrszb	%v20,%v16,%v18,%v19
   2ad0a:	a7 74 00 06       	jne	2ad16 <__strstr_arch13+0xa6>
   2ad0e:	41 20 20 40       	la	%r2,64(%r2)
   2ad12:	a7 f4 ff ca       	j	2aca6 <__strstr_arch13+0x36>
   2ad16:	41 20 20 10       	la	%r2,16(%r2)
   2ad1a:	41 20 20 10       	la	%r2,16(%r2)
   2ad1e:	41 20 20 10       	la	%r2,16(%r2)
   2ad22:	a7 24 00 4f       	jh	2adc0 <__strstr_arch13+0x150>
   2ad26:	a7 44 00 4a       	jl	2adba <__strstr_arch13+0x14a>
   2ad2a:	e7 15 20 00 60 27 	lcbb	%r1,0(%r5,%r2),6
   2ad30:	41 25 20 00       	la	%r2,0(%r5,%r2)
   2ad34:	a7 14 00 52       	jo	2add8 <__strstr_arch13+0x168>
   2ad38:	e7 00 20 00 08 06 	vl	%v16,0(%r2)
   2ad3e:	e7 40 20 20 3f 8b 	vstrszb	%v20,%v16,%v18,%v19
   2ad44:	a7 24 00 3e       	jh	2adc0 <__strstr_arch13+0x150>
   2ad48:	a7 44 00 39       	jl	2adba <__strstr_arch13+0x14a>
   2ad4c:	41 25 20 00       	la	%r2,0(%r5,%r2)
   2ad50:	a7 84 ff ab       	je	2aca6 <__strstr_arch13+0x36>
   2ad54:	e7 10 20 00 60 27 	lcbb	%r1,0(%r2),6
   2ad5a:	a7 14 00 3f       	jo	2add8 <__strstr_arch13+0x168>
   2ad5e:	e7 00 20 00 08 06 	vl	%v16,0(%r2)
   2ad64:	e7 40 20 20 3f 8b 	vstrszb	%v20,%v16,%v18,%v19
   2ad6a:	a7 24 00 2b       	jh	2adc0 <__strstr_arch13+0x150>
   2ad6e:	a7 44 00 26       	jl	2adba <__strstr_arch13+0x14a>
   2ad72:	41 25 20 00       	la	%r2,0(%r5,%r2)
   2ad76:	a7 84 ff 98       	je	2aca6 <__strstr_arch13+0x36>
   2ad7a:	e7 10 20 00 60 27 	lcbb	%r1,0(%r2),6
   2ad80:	a7 14 00 2c       	jo	2add8 <__strstr_arch13+0x168>
   2ad84:	e7 00 20 00 08 06 	vl	%v16,0(%r2)
   2ad8a:	e7 40 20 20 3f 8b 	vstrszb	%v20,%v16,%v18,%v19
   2ad90:	a7 24 00 18       	jh	2adc0 <__strstr_arch13+0x150>
   2ad94:	a7 44 00 13       	jl	2adba <__strstr_arch13+0x14a>
   2ad98:	41 25 20 00       	la	%r2,0(%r5,%r2)
   2ad9c:	a7 84 ff 85       	je	2aca6 <__strstr_arch13+0x36>
   2ada0:	e7 10 20 00 60 27 	lcbb	%r1,0(%r2),6
   2ada6:	a7 14 00 19       	jo	2add8 <__strstr_arch13+0x168>
   2adaa:	e7 00 20 00 08 06 	vl	%v16,0(%r2)
   2adb0:	e7 40 20 20 3f 8b 	vstrszb	%v20,%v16,%v18,%v19
   2adb6:	a7 f4 ff c7       	j	2ad44 <__strstr_arch13+0xd4>
   2adba:	a7 29 00 00       	lghi	%r2,0
   2adbe:	07 fe             	br	%r14
   2adc0:	e7 44 00 07 04 21 	vlgvb	%r4,%v20,7
   2adc6:	41 24 20 00       	la	%r2,0(%r4,%r2)
   2adca:	07 fe             	br	%r14
   2adcc:	41 20 20 10       	la	%r2,16(%r2)
   2add0:	41 20 20 10       	la	%r2,16(%r2)
   2add4:	41 20 20 10       	la	%r2,16(%r2)
   2add8:	a7 1a ff ff       	ahi	%r1,-1
   2addc:	e7 01 20 00 08 37 	vll	%v16,%r1,0(%r2)
   2ade2:	e7 51 00 07 08 22 	vlvgb	%v21,%r1,7
   2ade8:	e7 10 00 20 0e 81 	vfenezb	%v17,%v16,%v16
   2adee:	e7 15 00 00 0c d9 	veclb	%v17,%v21
   2adf4:	a7 c4 ff 61       	jle	2acb6 <__strstr_arch13+0x46>
   2adf8:	e7 00 20 00 08 06 	vl	%v16,0(%r2)
   2adfe:	a7 f4 ff 5c       	j	2acb6 <__strstr_arch13+0x46>
   2ae02:	a7 1a ff ff       	ahi	%r1,-1
   2ae06:	e7 21 30 00 08 37 	vll	%v18,%r1,0(%r3)
   2ae0c:	e7 51 00 07 08 22 	vlvgb	%v21,%r1,7
   2ae12:	e7 32 20 20 0e 81 	vfenezb	%v19,%v18,%v18
   2ae18:	e7 35 00 00 0c d9 	veclb	%v19,%v21
   2ae1e:	a7 c4 ff 34       	jle	2ac86 <__strstr_arch13+0x16>
   2ae22:	e7 20 30 00 08 06 	vl	%v18,0(%r3)
   2ae28:	e7 32 20 20 0e 81 	vfenezb	%v19,%v18,%v18
   2ae2e:	a7 f4 ff 2c       	j	2ac86 <__strstr_arch13+0x16>

