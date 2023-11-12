Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A767E92C5
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 21:45:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2HJa-0004os-MX; Sun, 12 Nov 2023 15:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r2HJN-0004oV-Lc
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 15:44:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r2HJL-00053m-8G
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 15:44:04 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40859c464daso30529085e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699821841; x=1700426641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nuKkz7mQOq17IJaC3wVcZl5PT7A/RGnCalTk1Z6cm4k=;
 b=DsqUD8/08J277T9fc3Wr4Iy7inQJGywCsRhnUCuKVgziWjpeNcrBTIKQXXgc9OqgAg
 jApDsK/Y0XuVYERulrpuB1GPgc08WatXMkMSd7qJ2iRXYIZEZwOGaaebq+lVwup5H5yT
 rTDO1QTm+szHKUKAohbORtMgaicBXm3I1hrnnddJt0LJBPIFWkPiT5sUQhuNvTKzF2i+
 mSHu5+NkyStYwsgIf79CdHzQt7ePi+kQAjT6bWhE0pB7i1Ot3vaYAqAMwXY+k/nMe33X
 rOrgBGNgatDmS2XqeCxaY9Dth/kCYG+O7ni5Wnwnoi+cbJOWjAi7lnuBX0keRbda0ODb
 Vj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699821841; x=1700426641;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuKkz7mQOq17IJaC3wVcZl5PT7A/RGnCalTk1Z6cm4k=;
 b=gmDi2hVt2EaGEJ9G1j1gFROKnCbdWpim4aitXLlJiSqpRMRvr0uZCXC1C9iVhFxu5F
 bR15mxS7nD2oZEdm1hZVbKYMoyNqkMY1+f1H8DhzAeVeEqs3xi4XpPCb5WKsgTmI7jY8
 a1amrl7sQG90maXmqvxy6q1C2SVDHINY0cf+SxhLJ80jMq1cgxuwcLN6vSJoEVg4Jrv4
 oNC25ioO3gvZoVzQhSQRthxQPSjV++zIiflmlEQKQR6SGaGMxVRikoKGDBwW8Umykw6o
 s245/5gjAX6LdTM5yhX3IQP54zvDGj2qYUTjGhG92vp55kkQRNx/v/OG2rOV4Qh9hUft
 rROA==
X-Gm-Message-State: AOJu0Yyhtxj70wU2INkys2wSrS6mSs7AV4a4VEq1OEmbbjbmalJmXrCU
 I+gbETqO1z8F7QFtsTXGBv4=
X-Google-Smtp-Source: AGHT+IHlMXE6LTQ+BDcUYetES5A5LmqI1g9ZnVfbIqmm9yoH0Db+HlTXJrXAQXM9VNjzLCvl28KiCA==
X-Received: by 2002:a5d:47c2:0:b0:32d:a7c8:eaf7 with SMTP id
 o2-20020a5d47c2000000b0032da7c8eaf7mr5145496wrc.20.1699821840859; 
 Sun, 12 Nov 2023 12:44:00 -0800 (PST)
Received: from [192.168.199.91] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a5d4f8b000000b0032d829e10c0sm3912544wru.28.2023.11.12.12.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 12:44:00 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <bfa9e029-9d86-4a44-a7d4-c182bf816d84@xen.org>
Date: Sun, 12 Nov 2023 15:43:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] xen: xenstore: add possibility to preserve owner
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Woodhouse <dwmw2@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20231110204207.2927514-1-volodymyr_babchuk@epam.com>
 <20231110204207.2927514-4-volodymyr_babchuk@epam.com>
Organization: Xen Project
In-Reply-To: <20231110204207.2927514-4-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 10/11/2023 15:42, Volodymyr Babchuk wrote:
> Add option to preserve owner when creating an entry in Xen Store. This
> may be needed in cases when Qemu is working as device model in a
> domain that is Domain-0, e.g. in driver domain.
> 
> "owner" parameter for qemu_xen_xs_create() function can have special
> value XS_PRESERVE_OWNER, which will make specific implementation to
> get original owner of an entry and pass it back to
> set_permissions() call.
> 

If QEMU is running in a driver domain then it should know whether the 
domid of the domain it is running in and use that. Yes, it is hardcoded 
to 0 at the moment but surely a backend domid (which defaults to 0) 
could be passed on the command line?

   Paul

> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>   hw/i386/kvm/xen_xenstore.c       | 18 ++++++++++++++++++
>   hw/xen/xen-operations.c          | 12 ++++++++++++
>   include/hw/xen/xen_backend_ops.h |  2 ++
>   3 files changed, 32 insertions(+)
> 
> diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
> index 660d0b72f9..7b894a9884 100644
> --- a/hw/i386/kvm/xen_xenstore.c
> +++ b/hw/i386/kvm/xen_xenstore.c
> @@ -1572,6 +1572,24 @@ static bool xs_be_create(struct qemu_xs_handle *h, xs_transaction_t t,
>           return false;
>       }
>   
> +    if (owner == XS_PRESERVE_OWNER) {
> +        GList *perms;
> +        char letter;
> +
> +        err = xs_impl_get_perms(h->impl, 0, t, path, &perms);
> +        if (err) {
> +            errno = err;
> +            return false;
> +        }
> +
> +        if (sscanf(perms->data, "%c%u", &letter, &owner) != 2) {
> +            errno = EFAULT;
> +            g_list_free_full(perms, g_free);
> +            return false;
> +        }
> +        g_list_free_full(perms, g_free);
> +    }
> +
>       perms_list = g_list_append(perms_list,
>                                  xs_perm_as_string(XS_PERM_NONE, owner));
>       perms_list = g_list_append(perms_list,
> diff --git a/hw/xen/xen-operations.c b/hw/xen/xen-operations.c
> index e00983ec44..1df59b3c08 100644
> --- a/hw/xen/xen-operations.c
> +++ b/hw/xen/xen-operations.c
> @@ -300,6 +300,18 @@ static bool libxenstore_create(struct qemu_xs_handle *h, xs_transaction_t t,
>           return false;
>       }
>   
> +    if (owner == XS_PRESERVE_OWNER) {
> +        struct xs_permissions *tmp;
> +        unsigned int num;
> +
> +        tmp = xs_get_permissions(h->xsh, 0, path, &num);
> +        if (tmp == NULL) {
> +            return false;
> +        }
> +        perms_list[0].id = tmp[0].id;
> +        free(tmp);
> +    }
> +
>       return xs_set_permissions(h->xsh, t, path, perms_list,
>                                 ARRAY_SIZE(perms_list));
>   }
> diff --git a/include/hw/xen/xen_backend_ops.h b/include/hw/xen/xen_backend_ops.h
> index 90cca85f52..273e414559 100644
> --- a/include/hw/xen/xen_backend_ops.h
> +++ b/include/hw/xen/xen_backend_ops.h
> @@ -266,6 +266,8 @@ typedef uint32_t xs_transaction_t;
>   #define XS_PERM_READ  0x01
>   #define XS_PERM_WRITE 0x02
>   
> +#define XS_PRESERVE_OWNER        0xFFFE
> +
>   struct xenstore_backend_ops {
>       struct qemu_xs_handle *(*open)(void);
>       void (*close)(struct qemu_xs_handle *h);


