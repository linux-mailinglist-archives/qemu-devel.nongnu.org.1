Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E53674978C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKSH-0002vw-2a; Thu, 06 Jul 2023 04:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHKSD-0002vX-MU
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHKSC-0006y2-6s
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688632507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w04dj23trQ7hpGACPVCce3z3LZ8lwKFK50rQ/YH0o2A=;
 b=gOXF4RTsM65g89o8LrJuSiVzollLYgYyRyKE86nZJ2GAZ7Csj/fNE+GC96+vrotVoLVBbY
 J2OdIwlDidNyw6L5QJTjVAappKT4WerNiAo7yO6UnV1ghqjW42DNgvVmiB7BBEjQsJoaCn
 bUvz94cLgDJCh8rvKFz/4RiakMn+ASE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Vze-VLJLOPuuMEf1h11Q8w-1; Thu, 06 Jul 2023 04:35:06 -0400
X-MC-Unique: Vze-VLJLOPuuMEf1h11Q8w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9879d2fc970so34635566b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688632505; x=1691224505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w04dj23trQ7hpGACPVCce3z3LZ8lwKFK50rQ/YH0o2A=;
 b=YT92jtKouLnvDzBBL/Et9QHIm1v0AicAn/CsVLUL0NwD0LWEq0v0CCyLXgGflKlXM2
 lMspfUIlbPTGCf+nWb8xz1Sb/ZM41tR2fJZBN1n/KjZGBdJEz6QeipxwwAWaXuBFQnJi
 h3FViIwLeR1iaBmX3vffCEOtUSXieGuJnzX6OwZMKSRDI/U96z6G8V85Ur7wdQylPjxk
 ozCQ5UbuxFuEcW+uvTmeazXphPGJe6c6smxrAlc/N1a40Ni0aQvxEWxO/r3H48iFuXJd
 X6lGjYifufaRM40gQrezTDXDfiq02pNXoRwTqtsi5xvLZgDV4g2ND/eit4llYW+CzCVD
 w8Pw==
X-Gm-Message-State: ABy/qLaq8tWsI/Y1MFhc4R0jAop4GLVekD8M+Vs061NZNOzG8p+rITux
 CXVtwNAur4yhMA9PrgOP6TUY4EcrqVGdljytb4/2J+rGNfvRwDXtYEkBsXIVhwss41HF0olj0X2
 WYZgkuUf0ZcU1SYA=
X-Received: by 2002:a17:906:72de:b0:991:dc98:69ff with SMTP id
 m30-20020a17090672de00b00991dc9869ffmr830658ejl.67.1688632505585; 
 Thu, 06 Jul 2023 01:35:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGL9CCvjNK3XzDVbUS9IA+0cXZ8k9upXU7Q/R4mz1edY8Dfyw/veDKBrmXLsNWUm+9V98VhJw==
X-Received: by 2002:a17:906:72de:b0:991:dc98:69ff with SMTP id
 m30-20020a17090672de00b00991dc9869ffmr830635ejl.67.1688632505211; 
 Thu, 06 Jul 2023 01:35:05 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 w14-20020a170906b18e00b00992ca779f42sm513507ejy.97.2023.07.06.01.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:35:04 -0700 (PDT)
Message-ID: <6734db8d-0873-6efd-918a-978a22a36085@redhat.com>
Date: Thu, 6 Jul 2023 10:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] meson.build: Remove the logic to link C code with the C++
 linker
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230706064736.178962-1-thuth@redhat.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230706064736.178962-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/6/23 08:47, Thomas Huth wrote:
> We are not mixing C++ with C code anymore, the only remaining
> C++ code in qga/vss-win32/ is used for a plain C++ executable.
> Thus we can remove the hacks for linking C code with the C++ linker
> now to simplify meson.build a little bit, and also to avoid that
> some C++ code sneaks in by accident again.

Queued, thanks.  However I think these two lines are worth keeping:

> +if 'cpp' in all_languages
>     summary_info += {'C++ compiler':    ' '.join(meson.get_compiler('cpp').cmd_array())}
> -else
> -  summary_info += {'C++ compiler':      false}
>   endif

Perhaps we could also make the whole if...endif conditional on Windows, 
but an extra line in the summary won't hurt.

Paolo


