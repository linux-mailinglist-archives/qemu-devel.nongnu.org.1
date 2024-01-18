Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2C831FA8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 20:24:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQXzM-0004Jh-7v; Thu, 18 Jan 2024 14:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQXzJ-0004JB-EV
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQXzH-0007Ni-5Q
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705605818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MPYi+K6Tlb0wDy7AZ8qK4d/752FmntsSeYomd6/e7n0=;
 b=OD2jAtUNkX3hmX3/cVa8D4/Br8uZYOUf4KCQdG3w/Dv+nBYKqPcdGteZ4RHENvKSG7dLv7
 Oi6Sqc1dTO/E9tQPfg22wnscVpmSrZ0LVGbkqOwoZm+e8AAa/ZeuXyRET69K5rRJK8BPVs
 6fPXwBHVGku90oAhawrPKBKsSmWntfc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-D_F7TFMpMuq46pJ62HZvqQ-1; Thu, 18 Jan 2024 14:23:31 -0500
X-MC-Unique: D_F7TFMpMuq46pJ62HZvqQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2b8bd6c6a3so849149466b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 11:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705605810; x=1706210610;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MPYi+K6Tlb0wDy7AZ8qK4d/752FmntsSeYomd6/e7n0=;
 b=urorB8JrMydDcapiu+SvYXwzdK7WgImdFNLGjYoCpshN1oBqr32vXmVz1sK5CjF45o
 2swaQc6WS0TsiF/8s2mSGaodBL+7NnId2Cz9nE3YAIFZx/HlHVDxDw+rqfnw9FIyGE3I
 eqvgAyO+s1Q8T4Wyp5JU+J5yxti5y1LxsBcPjgxNGsQzf6kSPO8xXUKi1S/tSDotofKg
 WPPoMV7qNHfTZo1qnwhPuPfpbkNUnZ/3nuvWb0Vvew+NQQ32TVKGDCTWPCFGgjPef4yU
 7ThfjgNnX+X9eocsAHS/IVy0QYxdecNefNQPJ6tRs7LYTebTWCfxp7j0ELAABZleiVgG
 hLHQ==
X-Gm-Message-State: AOJu0Yx65WXWepelzodfeHSncqHilf+gl6iWjuIhxCKW+NdofNFE++e9
 jSfQzMEEtxAXTg9awURPkDE3jyXuztKSGIXnYqBzFTaKiaDbBcfXTZDlob31VobeyyNQHbvOQ4i
 xr9qTZQXIVfx7IqbWbS92uyhPUQyx/XrA8UHRvEvvs16kJUyJbNfj
X-Received: by 2002:a17:906:a2d6:b0:a28:e980:898c with SMTP id
 by22-20020a170906a2d600b00a28e980898cmr731205ejb.90.1705605809817; 
 Thu, 18 Jan 2024 11:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8SKnzHCX+LTjKExxR8F8ehEUM9CzAiMhBGFty1FwTD7T+zv8ASWXUNnqtRva5H4wmL3A8gA==
X-Received: by 2002:a17:906:a2d6:b0:a28:e980:898c with SMTP id
 by22-20020a170906a2d600b00a28e980898cmr731201ejb.90.1705605809514; 
 Thu, 18 Jan 2024 11:23:29 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 gw7-20020a170906f14700b00a27741ca951sm9385587ejb.108.2024.01.18.11.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 11:23:29 -0800 (PST)
Message-ID: <a7897ccc-53c2-485a-ae3a-4dcdf53e738e@redhat.com>
Date: Thu, 18 Jan 2024 20:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] configure: remove compiler sanity check
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230511095021.1397802-1-pbonzini@redhat.com>
 <20230511095021.1397802-20-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20230511095021.1397802-20-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/05/2023 11.50, Paolo Bonzini wrote:
> The comment is not correct anymore, in that the usability test for
> the compiler and linker are done after probing $cpu, and Meson will
> redo them anyway.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/configure b/configure
> index 6e5e91908a4b..85f82a626964 100755
> --- a/configure
> +++ b/configure
> @@ -1090,20 +1090,6 @@ if test -z "$ninja"; then
>       fi
>   fi
>   
> -# Check that the C compiler works. Doing this here before testing
> -# the host CPU ensures that we had a valid CC to autodetect the
> -# $cpu var (and we should bail right here if that's not the case).
> -# It also allows the help message to be printed without a CC.
> -write_c_skeleton;
> -if compile_object ; then
> -  : C compiler works ok
> -else
> -    error_exit "\"$cc\" either does not exist or does not work"
> -fi
> -if ! compile_prog ; then
> -    error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
> -fi
> -
>   # Consult white-list to determine whether to enable werror
>   # by default.  Only enable by default for git builds
>   if test -z "$werror" ; then

  Hi Paolo!

When running "configure" on a system without C compiler, the user is now 
presented with:

  ERROR: Unrecognized host OS (uname -s reports 'Linux')

That's completely unhelpful. Could we maybe revert this patch to get a 
better error message again?

  Thanks,
   Thomas


