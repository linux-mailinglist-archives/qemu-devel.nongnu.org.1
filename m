Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBB79886A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:18:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecJ1-0006w5-OD; Fri, 08 Sep 2023 10:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qecIu-0006vl-Rb
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qecIr-0000Mh-Ig
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694182664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLRBu6WE0GHroC+ztvR/WvWi01A+bIcomkbtzqYX5l8=;
 b=dJJ90CrZxSUDlZyyOFB48Qr/2AExljS5jYE4eo7pcfkP+9e1yjiAd4RXUljEyWu3G7bSDt
 Ow8xJLwICEiQWU/o/PepQMPjhSRDTjFp4DlTGDPcleX21Ask9j62YvfwJyb0E5yMa4T89S
 JxH/RMBuPD09n7ag2d13x/QmFvX81EE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-BHQssPRDNwOtbRPdaC1e-A-1; Fri, 08 Sep 2023 10:17:43 -0400
X-MC-Unique: BHQssPRDNwOtbRPdaC1e-A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9aa05c1934aso25582166b.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694182662; x=1694787462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLRBu6WE0GHroC+ztvR/WvWi01A+bIcomkbtzqYX5l8=;
 b=IJDHvSJyXAXSONsqvheIpm4iotseETOZP8gCbCUbL2dC38zGx60+Gj9e+AziUFsHCA
 9KIOqJe2idTUTxBYh3x8K2VwotXH/k78mIloilPTcI7iBUp/9GbJ4uZ55aSR8uZewcye
 1nGbRQ1eB3k1j2zGLlPq4nCRP3/bsLKL26/ubZucHFUcRjodDM4RW+UYAwmHC6fQ7ADq
 CtPifD6IHjy2818V+An7r7HiCcwUT5yxPurYAUiy5ZyAnfNiaWJy50uACHA59avH8on6
 LEDKRpDei5aaYB4oWrcEH94R+ITQWryDG6Wf2hRd7Oq71yV7A3Wwi+dvW0b3RzdDnWyq
 EMBA==
X-Gm-Message-State: AOJu0YyNgAg6KrjgZtkiBZxiL6uL9hUTBukSYs/MUvHEzUPYQneMcNwv
 LEZ8zMXx0NWZGe1aTo+Lf+c3cUZYlRCC0bWF3bnWpIWILdxTqMc5fnG7SSA3NGZsWFEK+ZMHQkQ
 JGNXhkV0/n1CxT2I=
X-Received: by 2002:a17:906:304b:b0:992:2f67:cd34 with SMTP id
 d11-20020a170906304b00b009922f67cd34mr3078446ejd.22.1694182661916; 
 Fri, 08 Sep 2023 07:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ok6T/E/vMSkAwtqrbuY3CnHns+PDMpwJmeU/2FbzbqNbO36s7jAb6LjtFw7IeBE+9oQkRw==
X-Received: by 2002:a17:906:304b:b0:992:2f67:cd34 with SMTP id
 d11-20020a170906304b00b009922f67cd34mr3078395ejd.22.1694182661108; 
 Fri, 08 Sep 2023 07:17:41 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 g2-20020a1709064e4200b009929ab17bdfsm1092771ejw.168.2023.09.08.07.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 07:17:36 -0700 (PDT)
Date: Fri, 8 Sep 2023 16:17:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 02/10] target/i386: Fix feature names in
 FEAT_VMX_EPT_VPID_CAPS
Message-ID: <20230908161731.50fa79f4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230908124534.25027-3-twiederh@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908124534.25027-3-twiederh@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri,  8 Sep 2023 14:45:26 +0200
Tim Wiederhake <twiederh@redhat.com> wrote:

> Fix a copy-paste-mistake in the FEAT_VMX_EPT_VIPD_CAPS cpuid leaf.
> The mistake became apparent as there were two features with the same name
> in this cpuid leaf. The names are now in line with SDM volume 3, appendix A,
> section 10.

these names are user facing ABI, and changing
them will break users that set these properties on command line.

maybe in addition opencode legacy aliases for them (initfn|realize time)
+ deprecate old names (so we can drop them eventually)
   + warning if old name is used (not sure how to do it easily though)
 
> Fixes: 20a78b02d3 ("target/i386: add VMX features")
> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7c2c48ac06..f10d343935 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1322,8 +1322,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              "vmx-invvpid", NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> -            "vmx-invvpid-single-addr", "vmx-invept-single-context",
> -                "vmx-invvpid-all-context", "vmx-invept-single-context-noglobals",
> +            "vmx-invvpid-single-addr", "vmx-invvpid-single-context",
> +                "vmx-invvpid-all-context", "vmx-invvpid-single-context-noglobals",
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,


