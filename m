Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB2776BCAD
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:42:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuKC-0002VB-3s; Tue, 01 Aug 2023 14:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuJz-0002Uc-Bf
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuJx-00087v-GT
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690915331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHWz2pt70mH0rFVvUPaUo5Bfd6lIDZefGErSbt7EJOs=;
 b=MYBBNXo9/XeagN7LD7vwas4ZDru+5LG/mVkWnUfqZSBy4ozL7wPUBeMP+30pybqXTGzD53
 361hgRoZciHT2hwMvzFHDpwP3yRkkxqx9lK/LFEyNH6COB30y0w59PIcE3/fSmMGBeIkGt
 gXRDVJbq1tvDUxzqg+1B1K9HF/q9qfU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-hmAVIXN1N_OTQCmBN4NYqg-1; Tue, 01 Aug 2023 14:42:10 -0400
X-MC-Unique: hmAVIXN1N_OTQCmBN4NYqg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-408d32b89e8so30625751cf.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915330; x=1691520130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHWz2pt70mH0rFVvUPaUo5Bfd6lIDZefGErSbt7EJOs=;
 b=U5S1YXVoaNMu1i917f/qKIQg0KqL33kwPqTDjWiPrmGyXfF+AqBtxuzX4MlrXhHDV7
 f9DmDqvK79fzzQrojX4hFQ5PYthZpoC9j0TbyErtIztyfRCTBkAMD0T8mNA8ecTzwpKG
 a8kcDpcgqrYaExfrHQI7oRaWtTp/9U2thIsqNxdtKh6zhkx/Lucg8jqQGPEO31NW3WNP
 gv6tdtopi4NHm298Fny6geZxtrsPJ04tUAl43F5gfu36ZWd01sCkO+OXdYKgrc4iimI0
 neTkaaM5I3ZMYsd3hoOsEYp4p0t+uSQCEnKsTQMX8gx4EODg86/jqM2yB6TDBJKA5E18
 2VPg==
X-Gm-Message-State: ABy/qLYkSJ6vqp9ad4snJTPHFxoq74TB4lj3lnQ+FIaigCmfhHXqrxTw
 R725TSNJ0BsDQW0nGov0H+1ZjaEyHQX75qNP3C8PiFCDi5KE6z499y2aWSCuy1oNVjntnFnHB9Z
 JNGvh3nTflcnqkY4=
X-Received: by 2002:a05:622a:d1:b0:403:b4da:6f65 with SMTP id
 p17-20020a05622a00d100b00403b4da6f65mr13000110qtw.39.1690915329783; 
 Tue, 01 Aug 2023 11:42:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkufD8mEe4LNprmEiUi/3GKJeJPx9VUgvJr89k15j+q9Rbz3Ex/eboP0qlUVu1pAjStwLCbw==
X-Received: by 2002:a05:622a:d1:b0:403:b4da:6f65 with SMTP id
 p17-20020a05622a00d100b00403b4da6f65mr13000090qtw.39.1690915329555; 
 Tue, 01 Aug 2023 11:42:09 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 d7-20020ac800c7000000b0040fd6dfeca9sm629631qtg.68.2023.08.01.11.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:42:09 -0700 (PDT)
Message-ID: <43afccca-6828-8cdb-47a7-2feb548d330d@redhat.com>
Date: Tue, 1 Aug 2023 20:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/8] configure: support passthrough of -Dxxx args to meson
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-7-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230801130403.164060-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 01/08/2023 15.04, Daniel P. Berrangé wrote:
> This can be useful for setting some meson global options, such as the
> optimization level or debug state.xs
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   configure | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/configure b/configure
> index 26ec5e4f54..9fe3718b77 100755
> --- a/configure
> +++ b/configure
> @@ -757,6 +757,9 @@ for opt do
>     # everything else has the same name in configure and meson
>     --*) meson_option_parse "$opt" "$optarg"
>     ;;
> +  # Pass through -Dxxxx options to meson
> +  -D*) meson_options="$meson_options $opt"
> +  ;;
>     esac
>   done
>   
> @@ -887,6 +890,8 @@ cat << EOF
>     pie             Position Independent Executables
>     debug-tcg       TCG debugging (default is disabled)
>   
> +  -Dmesonoptname=val      passthrough option to meson unmodified

I'd rather place that earlier in the help text, above the 
"meson_options_help" line in the configure script, next to the other 
--option=something lines.

  Thomas

>   NOTE: The object files are built at the place where configure is launched
>   EOF
>   exit 0


