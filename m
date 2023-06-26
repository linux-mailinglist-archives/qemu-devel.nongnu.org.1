Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC45273E0DB
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmST-0004Xc-LP; Mon, 26 Jun 2023 09:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qDmSN-0004Mj-CR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qDmSL-0003EA-HP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687786836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywfUqlVPO9EMEETtlDBOiC/fKtUMuk987y8uL0j+9AQ=;
 b=RV7jE7mqeWCBB+Obe+wCQtzniDOEZqV80e/sVGcwG2egOa6GSRi6bsBw2RRoIq3DKgAx8l
 p/q1aSt8ELR5+zbA0ORklIQBhocS7Q+HQS7K5gnBDnIBfnM9y7UVvYV7MUwPSvtIJM3wMg
 vGl5c8w3jLgnUTCY2vaV1YEpLSGxrlA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-kXPDMv1tNxypkW6izsVM4A-1; Mon, 26 Jun 2023 09:40:34 -0400
X-MC-Unique: kXPDMv1tNxypkW6izsVM4A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4009a8498f7so14575021cf.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687786834; x=1690378834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ywfUqlVPO9EMEETtlDBOiC/fKtUMuk987y8uL0j+9AQ=;
 b=eULgsMqktZSx4rvijDho9U3jyvMHIpksPdh3r+rtbhQTHoeXNvD4h8Kb/qmvRCgWKN
 iKynxh524D5/ZiqQFeqgU7aztObRyqiE6Lgh5d+fZ+VYyN2LTciyvxMYdHEX8PvdG9Sx
 6L4ktq4H4Fz1skcAhHJp9SjkCcnlLtCLvrgZdhENhoJ5dYgwFyLM+yVZONkASyWxKA6j
 gfmz7R2lfcvZev9DrJS8KyoEEFfFF1BhYq/EcCTVeJEBhdtGUEkZE3pjOdcWrIx4kjQY
 Ui7IishYa7JIQhnfXb/jCMDAX7HQsR/c+2jxflqLRiKpAV2Q2X4JyUVzPe3bLiWLY77m
 46cg==
X-Gm-Message-State: AC+VfDwL4i2vVlBuEIRgjK1b/53qqtaLqlmq9aRIPHf6J9DfBj+PRKzw
 2k+PiDEL2UPGQd0WZx+ty4uTiWU/15e46Jhpoeqw/V+hhXtTU9qTCV/I6V6CCZF6ZyT4PZeArBS
 8DPEp3gFt4lmPA+Y=
X-Received: by 2002:a05:622a:1993:b0:400:9ab5:b6e with SMTP id
 u19-20020a05622a199300b004009ab50b6emr6577286qtc.35.1687786833835; 
 Mon, 26 Jun 2023 06:40:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+HL0gH2i6goaHweiMIdI+7btAX/mS8jsUI0+vIJhIZX7F6UpVzUvO3guhJ8vOntk56cLI7A==
X-Received: by 2002:a05:622a:1993:b0:400:9ab5:b6e with SMTP id
 u19-20020a05622a199300b004009ab50b6emr6577270qtc.35.1687786833596; 
 Mon, 26 Jun 2023 06:40:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 cp4-20020a05622a420400b003f6be5256d5sm3047796qtb.19.2023.06.26.06.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:40:33 -0700 (PDT)
Message-ID: <108dc59e-7519-6156-f107-c7fe1a1f36eb@redhat.com>
Date: Mon, 26 Jun 2023 15:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] pc-bios/s390-ccw: Fix indentation in start.S
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 mrezanin@redhat.com, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230626132138.87668-1-thuth@redhat.com>
 <20230626132138.87668-2-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230626132138.87668-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/26/23 15:21, Thomas Huth wrote:
> start.S is currently indented with a mixture of spaces and tabs, which
> is quite ugly. QEMU coding style says indentation should be 4 spaces,
> and this is also what we are using in the assembler files in the
> tests/tcg/s390x/ folder already, so let's adjust start.S accordingly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   pc-bios/s390-ccw/start.S | 136 +++++++++++++++++++--------------------
>   1 file changed, 68 insertions(+), 68 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 6072906df4..d29de09cc6 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -10,37 +10,37 @@
>    * directory.
>    */
>   
> -        .globl _start
> +    .globl _start
>   _start:
>   
> -	larl   %r15, stack + 0x8000	/* Set up stack */
> +    larl    %r15,stack + 0x8000     /* Set up stack */
>   
> -	/* clear bss */
> -	larl %r2, __bss_start
> -	larl %r3, _end
> -	slgr %r3, %r2		/* get sizeof bss */
> -	ltgr	%r3,%r3 	/* bss empty? */
> -	jz	done
> -	aghi	%r3,-1
> -	srlg	%r4,%r3,8	/* how many 256 byte chunks? */
> -	ltgr	%r4,%r4
> -	lgr	%r1,%r2
> -	jz	remainder
> +    /* clear bss */
> +    larl    %r2,__bss_start
> +    larl    %r3,_end
> +    slgr    %r3,%r2    /* get sizeof bss */
> +    ltgr    %r3,%r3    /* bss empty? */
> +    jz      done
> +    aghi    %r3,-1
> +    srlg    %r4,%r3,8  /* how many 256 byte chunks? */
> +    ltgr    %r4,%r4
> +    lgr     %r1,%r2
> +    jz      remainder
>   loop:
> -	xc	0(256,%r1),0(%r1)
> -	la	%r1,256(%r1)
> -	brctg	%r4,loop
> +    xc      0(256,%r1),0(%r1)
> +    la      %r1,256(%r1)
> +    brctg   %r4,loop
>   remainder:
> -	larl	%r2,memsetxc
> -	ex	%r3,0(%r2)
> +    larl    %r2,memsetxc
> +    ex      %r3,0(%r2)
>   done:
> -        /* set up a pgm exception disabled wait psw */
> -        larl	%r2, disabled_wait_psw
> -        mvc	0x01d0(16), 0(%r2)
> -        j      main		/* And call C */
> +    /* set up a pgm exception disabled wait psw */
> +    larl    %r2,disabled_wait_psw
> +    mvc     0x01d0(16),0(%r2)
> +    j       main       /* And call C */
>   
>   memsetxc:
> -	xc	0(1,%r1),0(%r1)
> +    xc      0(1,%r1),0(%r1)
>   
>   
>   /*
> @@ -48,11 +48,11 @@ memsetxc:
>    *
>    * stops the current guest cpu.
>    */
> -	.globl disabled_wait
> +    .globl disabled_wait
>   disabled_wait:
> -	larl	%r1,disabled_wait_psw
> -	lpswe	0(%r1)
> -1:	j	1b
> +    larl    %r1,disabled_wait_psw
> +    lpswe   0(%r1)
> +1:  j       1b
>   
>   
>   /*
> @@ -60,61 +60,61 @@ disabled_wait:
>    *
>    * eats one sclp interrupt
>    */
> -        .globl consume_sclp_int
> +    .globl consume_sclp_int
>   consume_sclp_int:
> -        /* enable service interrupts in cr0 */
> -        stctg   %c0,%c0,0(%r15)
> -        oi      6(%r15),0x2
> -        lctlg   %c0,%c0,0(%r15)
> -        /* prepare external call handler */
> -        larl %r1, external_new_code
> -        stg %r1, 0x1b8
> -        larl %r1, external_new_mask
> -        mvc 0x1b0(8),0(%r1)
> -        /* load enabled wait PSW */
> -        larl %r1, enabled_wait_psw
> -        lpswe 0(%r1)
> +    /* enable service interrupts in cr0 */
> +    stctg   %c0,%c0,0(%r15)
> +    oi      6(%r15),0x2
> +    lctlg   %c0,%c0,0(%r15)
> +    /* prepare external call handler */
> +    larl    %r1,external_new_code
> +    stg     %r1,0x1b8
> +    larl    %r1,external_new_mask
> +    mvc     0x1b0(8),0(%r1)
> +    /* load enabled wait PSW */
> +    larl    %r1,enabled_wait_psw
> +    lpswe   0(%r1)
>   
>   /*
>    * void consume_io_int(void)
>    *
>    * eats one I/O interrupt
>    */
> -        .globl consume_io_int
> +    .globl consume_io_int
>   consume_io_int:
> -        /* enable I/O interrupts in cr6 */
> -        stctg %c6,%c6,0(%r15)
> -        oi    4(%r15), 0xff
> -        lctlg %c6,%c6,0(%r15)
> -        /* prepare i/o call handler */
> -        larl  %r1, io_new_code
> -        stg   %r1, 0x1f8
> -        larl  %r1, io_new_mask
> -        mvc   0x1f0(8),0(%r1)
> -        /* load enabled wait PSW */
> -        larl  %r1, enabled_wait_psw
> -        lpswe 0(%r1)
> +    /* enable I/O interrupts in cr6 */
> +    stctg   %c6,%c6,0(%r15)
> +    oi      4(%r15), 0xff
> +    lctlg   %c6,%c6,0(%r15)
> +    /* prepare i/o call handler */
> +    larl    %r1,io_new_code
> +    stg     %r1,0x1f8
> +    larl    %r1,io_new_mask
> +    mvc     0x1f0(8),0(%r1)
> +    /* load enabled wait PSW */
> +    larl    %r1,enabled_wait_psw
> +    lpswe   0(%r1)
>   
>   external_new_code:
> -        /* disable service interrupts in cr0 */
> -        stctg   %c0,%c0,0(%r15)
> -        ni      6(%r15),0xfd
> -        lctlg   %c0,%c0,0(%r15)
> -        br      %r14
> +    /* disable service interrupts in cr0 */
> +    stctg   %c0,%c0,0(%r15)
> +    ni      6(%r15),0xfd
> +    lctlg   %c0,%c0,0(%r15)
> +    br      %r14
>   
>   io_new_code:
> -        /* disable I/O interrupts in cr6 */
> -        stctg %c6,%c6,0(%r15)
> -        ni    4(%r15), 0x00
> -        lctlg %c6,%c6,0(%r15)
> -        br    %r14
> +    /* disable I/O interrupts in cr6 */
> +    stctg   %c6,%c6,0(%r15)
> +    ni      4(%r15),0x00
> +    lctlg   %c6,%c6,0(%r15)
> +    br      %r14
>   
> -        .align  8
> +    .align  8
>   disabled_wait_psw:
> -        .quad   0x0002000180000000,0x0000000000000000
> +    .quad   0x0002000180000000,0x0000000000000000
>   enabled_wait_psw:
> -        .quad   0x0302000180000000,0x0000000000000000
> +    .quad   0x0302000180000000,0x0000000000000000
>   external_new_mask:
> -        .quad   0x0000000180000000
> +    .quad   0x0000000180000000
>   io_new_mask:
> -        .quad   0x0000000180000000
> +    .quad   0x0000000180000000


