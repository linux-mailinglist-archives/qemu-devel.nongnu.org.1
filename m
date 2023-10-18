Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 789507CDB41
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:06:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5Il-0008Af-TW; Wed, 18 Oct 2023 08:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt5Ij-0008AF-3g
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt5If-0003iT-RZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697630720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qH9CQFX98asudpDkMQddGXjROVjXOu9ERE5DKOV0w7M=;
 b=BxViP2qA0M4qxiVV9hXLhgan5OIkFA+Z02t2oRgfS8mTBX9ar96d7FF+DTmdZj+bJeOkmH
 LtSlqt5IAw/IZLgWGt4TSoy1Hd2i7gBkDPOXjymeLNZBXJoRujpR9g99jmDCxf3yJqS9jM
 cEoWBJOjk2RwpnUKkn4Wm6pV3E0n1hQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-nzpQRzPeNti4mmwhGJO6AQ-1; Wed, 18 Oct 2023 08:05:19 -0400
X-MC-Unique: nzpQRzPeNti4mmwhGJO6AQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso501675166b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 05:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697630718; x=1698235518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qH9CQFX98asudpDkMQddGXjROVjXOu9ERE5DKOV0w7M=;
 b=uPj9ZB8DmyEuVK/n4vx2zRAs4tlVb9I2IdHoNclzWbTZ923BMVothSzGVGuAukzNmj
 NNmLEAYWC4c5ZC7W4Q88p6asnkDm4UOKEhjFyBIiGhAWnkSLWAitu4OfC4zEHj40WKK8
 /Y+ypxi69cNlfb4likSWNYihNJG/EfauotDhtQ5pURVkQiUCBT5s/i+ZLvBJCAV1e+/e
 727cog3qla/LacAr0UREZ9e7E42FjTlmZTg+fS2Aka651S3Ds8KqldTSAlBgj5OXolvH
 J9N85QLFk8FvNLufnjQUVsZ2mQGBilPwPqsDmJtEZ9I4U+W1XbezrJiWouk2QhNuDjFJ
 Lf9w==
X-Gm-Message-State: AOJu0YwpS7OAuq277tn0jOrv2F7TvpdQOJjtpu0ImkQWUoj18o55NkBf
 WhgNDA+M1zFS857/SRi3Hf8Ll4lIz3psbPT2DMxAZkkqMc0D8jopH4G4fiJM/okY8pXs7sVN+AB
 msqLPIXH/spEEUwY=
X-Received: by 2002:a05:6402:26cc:b0:53e:3584:d395 with SMTP id
 x12-20020a05640226cc00b0053e3584d395mr4387431edd.34.1697630717896; 
 Wed, 18 Oct 2023 05:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGetRYzW08JxI56q8zpiogn7gr08v6Bj2/0Slvzy0fgzPfacBgG8FFMArBka6rxy9J+eLfnEg==
X-Received: by 2002:a05:6402:26cc:b0:53e:3584:d395 with SMTP id
 x12-20020a05640226cc00b0053e3584d395mr4387409edd.34.1697630717571; 
 Wed, 18 Oct 2023 05:05:17 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 j30-20020a508a9e000000b0053f11e3c019sm2722485edj.90.2023.10.18.05.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:05:16 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:05:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: david@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] cpu/cpuid: check CPUID_PAE to determine 36 bit processor
 address space
Message-ID: <20231018080451-mutt-send-email-mst@kernel.org>
References: <20230912120650.371781-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912120650.371781-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 12, 2023 at 05:36:50PM +0530, Ani Sinha wrote:
> PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on the
> guest processor and set phys_bits to 36 if PAE feature is set. This is in
> addition to checking the presence of PSE36 CPUID feature for setting 36 bit
> phys_bits.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

who's applying this?

> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Note: Not sure what tests I should be running in order to make sure I am
> not breaking any guest OSes. Usual qtests pass.
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 24ee67b42d..f3a5c99117 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7375,7 +7375,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              return;
>          }
>  
> -        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
> +        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
>              cpu->phys_bits = 36;
>          } else {
>              cpu->phys_bits = 32;
> -- 
> 2.39.1


