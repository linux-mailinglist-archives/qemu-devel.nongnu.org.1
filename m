Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D117CD3A2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 07:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qszS5-00031i-Ds; Wed, 18 Oct 2023 01:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qszS0-00031V-Sg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qszRz-0002aH-BX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697608234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UwQ6TNt7KUMsBEgTzM+4MLTlDQavThAudJ8PY6FKbIg=;
 b=iCEKedrHXOQWwMxKnol7Ro9UtJlWTFSNfbiuInF5Ewg9R9wcbOKENQeR5UztGXrS2hJQ4t
 upGJIShdm77TGsLT4e6aYrNpeY7t+NHl11SK/1x8xQkAIpzGvjixqPNAaU8oEGjMvw0tRq
 Zwg95hux7EMk/FvjzFJqjNiW260UQ8I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-FUZHLF_SPNaOsfhoUPVpmA-1; Wed, 18 Oct 2023 01:50:32 -0400
X-MC-Unique: FUZHLF_SPNaOsfhoUPVpmA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d03dcdc6bso77887766d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 22:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697608232; x=1698213032;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UwQ6TNt7KUMsBEgTzM+4MLTlDQavThAudJ8PY6FKbIg=;
 b=OTAr5RoYrwE6G+jblYEaDyei0EWLxJzrqQEHuKjtZYWX2yAlNhX/iCCcPErUZJXog+
 UZ04XDEc3HfeT7JKt1LR5ZpvVQK5IEZquCdueGBH1O2EpOoi3XsPZvcdfa0nviMeWnm2
 EtyiMi18GEzljtUx4vrA2IRM84r8xFa5xgb84nhTBWPbXdmNPBtd0zWF7oge5ap64AF4
 Oog6XLY0PbPmNoFkqtql7WZhplsuoDQQ3SpXT/YX8Hhnq1IRYokii9yGzoEmZ/Bdu4sC
 b44q37A195Cjoh92RdnjwDcHdj8VpkmKfrJrQrDfN4LkF+7S853038mHUtjZ+02nlNzi
 5AuA==
X-Gm-Message-State: AOJu0YxGWbAsPegMmwHSW4BHNvCdU2tUMEvGuVBBCCzs5UfbxZKk9TU/
 I8Vyon6FzM1ASd5jJXn0z9r+suBqi98lvPxNu08nY0N2q/xAGUqadK8+td0QMoF5GEgy86qwdub
 eMtYeim2k/YlgVOI=
X-Received: by 2002:a05:6214:d4c:b0:655:d0e3:5067 with SMTP id
 12-20020a0562140d4c00b00655d0e35067mr5684690qvr.3.1697608231843; 
 Tue, 17 Oct 2023 22:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtWQU9tBWkvmllASXcwyw/hSyF1BhMcwAUzRiGnw4eXzTMdBrIkNg71WH5LmxFJNnGD1AkwA==
X-Received: by 2002:a05:6214:d4c:b0:655:d0e3:5067 with SMTP id
 12-20020a0562140d4c00b00655d0e35067mr5684680qvr.3.1697608231547; 
 Tue, 17 Oct 2023 22:50:31 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 e25-20020a05620a209900b0077434d0f06esm1229187qka.52.2023.10.17.22.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 22:50:31 -0700 (PDT)
Message-ID: <07e4463f-d783-4cfc-8529-c2b041229568@redhat.com>
Date: Wed, 18 Oct 2023 07:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: define "pkg-config" in addition to "pkgconfig"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231017153649.309128-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231017153649.309128-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 17/10/2023 17.36, Paolo Bonzini wrote:
> Meson used to allow both "pkgconfig" and "pkg-config" entries in machine
> files; the former was used for dependency lookup and the latter
> was used as return value for "find_program('pkg-config')", which is a less
> common use-case and one that QEMU does not need.
> 
> This inconsistency is going to be fixed by Meson 1.3, which will deprecate
> "pkgconfig" in favor of "pkg-config" (the less common one, but it makes
> sense because it matches the name of the binary). For backward
> compatibility it is still allowed to define both, so do that in the
> configure-generated machine file.
> 
> Related: https://github.com/mesonbuild/meson/pull/12385
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configure b/configure
> index 8827a29bf4c..b4ea78c77d8 100755
> --- a/configure
> +++ b/configure
> @@ -1736,6 +1736,7 @@ if test "$skip_meson" = no; then
>     echo "ar = [$(meson_quote $ar)]" >> $cross
>     echo "nm = [$(meson_quote $nm)]" >> $cross
>     echo "pkgconfig = [$(meson_quote $pkg_config)]" >> $cross
> +  echo "pkg-config = [$(meson_quote $pkg_config)]" >> $cross
>     echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
>     if has $sdl2_config; then
>       echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross

Reviewed-by: Thomas Huth <thuth@redhat.com>


