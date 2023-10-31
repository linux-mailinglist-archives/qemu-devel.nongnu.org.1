Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F17DCF93
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:48:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxq1M-0002on-Gk; Tue, 31 Oct 2023 10:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxq1C-0002XL-Fy
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:47:00 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxq1A-0002dH-Vg
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:46:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9be3b66f254so856942066b.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763615; x=1699368415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5p4cIP5s3u9B2uqswrz/SwpLmirqCCcLd9UNYHt+d0=;
 b=sa5aJqLKWM3S1PckGprpQYPBDby37T7b23X7Us36k5AwaDETwwD9ZjTH8kj3hmZzoU
 415F2XexyGBYXOwKYvH6jCQ6qb9PE5a20KHvkXzCInRRY90CcePzl9lZeVnURN1jF0ab
 ZloAmAZPn4lp9FmN5Nc1wdCAi6Ns5km6YOOJoYhIfjruvaNqRExVRC3gB7MXZK8IbWu0
 HFSrY93sXZrKbDFM9GON+xTWb258ZETjtd2J5btj5wDp8QtKI2wcFR27kXETv7gTo+GW
 1RN9/hf+eBdALbhfuuvlVc/Jsmjgo6i0MfcFbbngGScmPmVy+CGio4GkMCJWoiO+Z2sh
 fh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763615; x=1699368415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5p4cIP5s3u9B2uqswrz/SwpLmirqCCcLd9UNYHt+d0=;
 b=iQOyyCzBS+1mSNWl93oFc7QcxTeBRckzTz5y0wYYV9847UKr1Z3i62EWwCrMH32AXS
 MaBivrirV9ObbcyqRLMlqlEbPmSC+OvdiFqmGAeoPd0+HW5nl89KDj+XWjcESCJ0kGMk
 BXosZa3rMCO+1qC6Yw/wM3CtqB5rG1BrszUnhDIVaVeh0AjsMb73ze3H6vs/Wcy0Df3y
 C0C42U7ThmaBJm5iORGwF/pdR2jVEeERE668FX5EVzw4OhEAXa6TQQkOUtg8M5Jst/uQ
 t4fWITBInuR9X/FBnlV2esqzd3bnNBPYBOdYvgEVwSKt8Cd79kYG8xADB28O8lDK190V
 YcOA==
X-Gm-Message-State: AOJu0YyIoRzXx8QMt9HBzrIfd3KbVrw6PHjd5aRtUiYmbiEE32LgKBE3
 3OGSlzyMmZJDZOJfdVK+PEag3g==
X-Google-Smtp-Source: AGHT+IH6/EHbbeLjNmjLlrqP+86U0C9YvDlHzq+sBmq45OJ6PBXD1RueMEYmpVjd7YRhbRAR7ajguA==
X-Received: by 2002:a17:907:8690:b0:9c7:5c46:3987 with SMTP id
 qa16-20020a170907869000b009c75c463987mr11947373ejc.63.1698763615172; 
 Tue, 31 Oct 2023 07:46:55 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 u19-20020a170906c41300b009b2cc87b8c3sm1067125ejz.52.2023.10.31.07.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:46:54 -0700 (PDT)
Message-ID: <62b7af6c-8091-2ee1-cc4d-01cf7c9ebfcb@linaro.org>
Date: Tue, 31 Oct 2023 15:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/7] ui/qmp-cmds: Improve two error messages
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231031111059.3407803-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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
> set_password with "protocol": "vnc" supports only "connected": "keep".
> Any other value is rejected with
> 
>      Invalid parameter 'connected'
> 
> Improve this to
> 
>      parameter 'connected' must be 'keep' when 'protocol' is 'vnc'
> 
> client_migrate_info requires "port" or "tls-port".  When both are
> missing, it fails with
> 
>      Parameter 'port/tls-port' is missing
> 
> Improve this to
> 
>      parameter 'port' or 'tls-port' is required
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   ui/ui-qmp-cmds.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


