Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303827DCEA4
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:06:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpNF-0003vt-8P; Tue, 31 Oct 2023 10:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxpN9-0003uu-He
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:05:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxpN4-0002ly-A8
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:05:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so41381875e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698761128; x=1699365928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TfMz5n3Vxh7B0MJrNZ6xvhtzQOeC2+R2YNl9WSwp91w=;
 b=iV+vKunHUvpdJb36ROnJXgrUdjh0nMLPH1tQiUNiqWexD5VclYmQ43K3y87inCJxs5
 5sfP9e0auYMPykqSdGpKpNVnJS9sZ+iaTaiCCETIrkB/6xpgsCkxOHa3Q+36N2l3Ktno
 S0odg0+IIz6Vi0xaGc8MAXjyJfT2VcTU12RP/To622EWmS9vmpv400sfgCsr/8BeF/G+
 N9Uq7U0wkjwfLo+ODef9BLojgdW2jP1563rjHvHxSVbiok1vGOGsMOY3Ea49NMveGN1V
 WC6oW+hZul0Wy9ZBU9paYftol2g+QT+tbfn+rQqFonyHbvfsRxzSGgIVPjtxQpJOp6SC
 RNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698761128; x=1699365928;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfMz5n3Vxh7B0MJrNZ6xvhtzQOeC2+R2YNl9WSwp91w=;
 b=lVAiVFJxdMzfYSR1rjVj8DswdzS4zFTpYdHC4dLDf41BEDcxtAxoaxsSazWTD19xAT
 myY0LvcRZz7H456oKNU+4v4o1nprE/d1sYunOsJdd/bd6Cx5CAlZlcN6e/vghGeO8C5F
 2WUY0xdNxVYL33jRRsyXCh1AYBzyc+fYtZzpbp5aFSIru3+Z7iUXDVat0z2qZcalsxrH
 gbhKiMElkYPgaLTNoUmjM1rm3CejEG00OPvnhzyDkU/igOtJ5yonEleUehg20Dxx8Is1
 Gvf5309k7vTzVQnOaH7pqzFDdvN86zdscDCWmuZlGPVWfWfRvPWTlzg/qiJ1IiuanK8Q
 uOtw==
X-Gm-Message-State: AOJu0Yzz8EU3+AflMGu7Sfqbdjira+/V1JcJvf2yjH4E6oyQ73+dY8Gx
 kBTKt3h9W51nRJTDmDOVyq19XA==
X-Google-Smtp-Source: AGHT+IHyZq4s/sA4pxTlY9pnxeQuJQgntQN3EUDP7DIzRJA8SrdhRc1V5LjnI8z+35iwnMX2LddqcA==
X-Received: by 2002:a05:600c:3b20:b0:407:612b:91fb with SMTP id
 m32-20020a05600c3b2000b00407612b91fbmr10230008wms.30.1698761128267; 
 Tue, 31 Oct 2023 07:05:28 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c468f00b003fe1c332810sm1857196wmo.33.2023.10.31.07.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:05:27 -0700 (PDT)
Message-ID: <6778fb84-9731-7fce-a6f5-d93cb83270ea@linaro.org>
Date: Tue, 31 Oct 2023 15:05:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/7] hmp: Improve sync-profile error message
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231031111059.3407803-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 31/10/23 12:10, Markus Armbruster wrote:
> Improve
> 
>      (qemu) sync-profile of
>      Error: Invalid parameter 'of'
> 
> to
> 
>      Error: invalid parameter 'of', expecting 'on', 'off', or 'reset'
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor/hmp-cmds.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


