Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D1F7AF0BB
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAxK-0002H2-RU; Tue, 26 Sep 2023 12:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlAxH-0002GT-UW
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlAxG-0007iB-Ge
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695745833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8s+4foMIG4e0VHKC8AQqo95oLvDmDenuHpJP+HiBpus=;
 b=aFqMYFkAMhbJ9bZ6ZJZjuXspTIQ9bQyHlEcsbSzfHZ4AYleegxDivFYfsZKeVEnf5Vi9uu
 8IBKtYTNn+hD3CBxHCApL6/ml3XpiHSj0X2J+/gDd0LMXfXthWgLjSOSp2nm8MONB+ZcVW
 ulAcz2h81j7/sdkT3d878Pk38M80NpY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-aCmQHv-lM3qcff1FQB0tDA-1; Tue, 26 Sep 2023 12:30:31 -0400
X-MC-Unique: aCmQHv-lM3qcff1FQB0tDA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b13294747so66966916d6.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695745831; x=1696350631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8s+4foMIG4e0VHKC8AQqo95oLvDmDenuHpJP+HiBpus=;
 b=PjaWNRAAhp4GrGVh1WLWMQhYAlolrQUV6aSd6jGh+Pwpv/eUXM0zYmxr7VfDKpjnI0
 DhPNPyMdLeqWFFTfqKjYIMk/PMSZ3/R0N9ywU8kZxogWXLnID+/frz5X0d6yFqh+eWdj
 eDrjNpeIGPXzL80VGzjs1Sv/8cwBZsyxuizTg8Rco2VR2+1GrhfyE7sl3unVxlntAyej
 bimRQMnnvHBYcWsfozCB7Jap3XRBw5yFd2yDuRzzVhqKxcJA01vUCX+mkBsiVgM2+If/
 84a3Xvgzu7zDlaYrHtL+kanHxzDItRuAckKvScXeezmJr+8TrzaR5JQk6IxodRY0G0Pg
 nM8w==
X-Gm-Message-State: AOJu0YyrUOBq3ubZvqoaSF+MROGcfigFL/YxQ8aCjblPZhSTbbu20hME
 +fz1ibVoV+N5WNaD12KYagougzzG+fGFR6PJoekG/73SMABpilinaG0MDueV/2njMrDH+TOvYxn
 CybBb8YSy6j7rbIc=
X-Received: by 2002:a0c:9c83:0:b0:65b:10e3:9cc5 with SMTP id
 i3-20020a0c9c83000000b0065b10e39cc5mr4580904qvf.16.1695745831259; 
 Tue, 26 Sep 2023 09:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwRIKEzQ/v2SUtvRZWhqujqvv1ONSRXrtuKwIyMm9IiAVROOY8TS3NTWJULheFSYaDkGESuw==
X-Received: by 2002:a0c:9c83:0:b0:65b:10e3:9cc5 with SMTP id
 i3-20020a0c9c83000000b0065b10e39cc5mr4580887qvf.16.1695745830935; 
 Tue, 26 Sep 2023 09:30:30 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-189.web.vodafone.de.
 [109.42.114.189]) by smtp.gmail.com with ESMTPSA id
 h7-20020a0cf207000000b0065b09512e14sm2215510qvk.21.2023.09.26.09.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 09:30:30 -0700 (PDT)
Message-ID: <e058968b-6ff1-1365-4124-2764f2cbdabd@redhat.com>
Date: Tue, 26 Sep 2023 18:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] disas/m68k: clean up local variable shadowing
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230925084455.395150-1-laurent@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230925084455.395150-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/09/2023 10.44, Laurent Vivier wrote:
> Fix following warnings
> 
> .../disas/m68k.c: In function ‘print_insn_arg’:
> .../disas/m68k.c:1635:13: warning: declaration of ‘val’ shadows a previous local [-Wshadow=compatible-local]
>   1635 |         int val = fetch_arg (buffer, place, 5, info);
>        |             ^~~
> .../disas/m68k.c:1093:7: note: shadowed declaration is here
>   1093 |   int val = 0;
>        |       ^~~
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   disas/m68k.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/disas/m68k.c b/disas/m68k.c
> index aefaecfbd6cb..1f16e295ab41 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -1632,10 +1632,10 @@ print_insn_arg (const char *d,
>       case '2':
>       case '3':
>         {
> -	int val = fetch_arg (buffer, place, 5, info);
> +	int reg = fetch_arg (buffer, place, 5, info);
>           const char *name = 0;
>   
> -	switch (val)
> +	switch (reg)
>   	  {
>   	  case 2: name = "%tt0"; break;
>   	  case 3: name = "%tt1"; break;
> @@ -1655,12 +1655,12 @@ print_insn_arg (const char *d,
>   	      int break_reg = ((buffer[3] >> 2) & 7);
>   
>   	      (*info->fprintf_func)
> -		(info->stream, val == 0x1c ? "%%bad%d" : "%%bac%d",
> +		(info->stream, reg == 0x1c ? "%%bad%d" : "%%bac%d",
>   		 break_reg);
>   	    }
>   	    break;
>   	  default:
> -	    (*info->fprintf_func) (info->stream, "<mmu register %d>", val);
> +	    (*info->fprintf_func) (info->stream, "<mmu register %d>", reg);
>   	  }
>   	if (name)
>   	  (*info->fprintf_func) (info->stream, "%s", name);

Reviewed-by: Thomas Huth <thuth@redhat.com>


