Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3165AB8C38
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 18:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbKZ-00039H-Ek; Thu, 15 May 2025 12:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFbKU-0002z3-Ax
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFbKS-0002aq-9k
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747326063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M4ew/OKUmQKm3+H04IB/+Nzx90AyyXvoHSdUUn09lNk=;
 b=Dzx2W++eET4Ggrj8BuwRRhD3mMdnfhrhNnTbB+VVMyrYO9EPNW+Ni1E5lquUVWkcMIe54k
 jS7QJoP3tuYwnMTbL3D+OE3QjL9a0Ckn5zbSFa672E26tKhnjtwGf9Xyx2p+oORC8CO+8Q
 YF58KaLM/Mn+7yUhMUg9ynATz1XcD4I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-ppPVBHAKPa-VPVxnq7Djsg-1; Thu, 15 May 2025 12:21:01 -0400
X-MC-Unique: ppPVBHAKPa-VPVxnq7Djsg-1
X-Mimecast-MFC-AGG-ID: ppPVBHAKPa-VPVxnq7Djsg_1747326060
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so9279705e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 09:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747326060; x=1747930860;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4ew/OKUmQKm3+H04IB/+Nzx90AyyXvoHSdUUn09lNk=;
 b=cFJfaPcGEt23F5OfmzUPNGavlu2VTh2R67x+njLJJpQdr7N2M2sK2sjaybyvQRymXx
 TeGcGaiR3u2Du49+Rd0vC2bX66F2i5qNhIKHDgT1/QpsoksJf+201+WL/0iWgjfOaZVY
 /Ej5IWGGOZpUE6fUXBpT/N8a5FgXbKPjePSc1EIOeUNKKXYn8MtLVDY19OPQcoRf2OqX
 9FrBEOXwtpbefrCiCfF5mEdaWHH29bwROXUxZ5xr2mtDGJfe/DONf3AN5Z0dc1/yeBLQ
 v1duQr5UTtNsTH3Uf7ZG+jygKu/TgPO6hkNoerHCv9bjkUWGDN88ySWjJzjSwC+7qDZs
 Q00w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7TsZ5B3/q3gL2Gj+V2OS3kPES5W486bQ2XZL/hEONRILjC50Bjk63vyWZvL6BwkS85VdvYRRMZLkw@nongnu.org
X-Gm-Message-State: AOJu0YwN16jQL2i7EGI+1GRIkFf/+rlwvctFJI4A95SjI7jMPLhqJ9PF
 cggCrdmCaPeDlyoqCpFvg3ervUA75Ujosx2xIel5Pr3+8xGvZnyDGPdCQa51dnDtdYSdIz1P+Xu
 b+PLXgFSkfTqpZqldi04Sw+50C+GRYTatCdfp/UopDUdUBq7xZAroGWOL
X-Gm-Gg: ASbGncs/PqadlyUY2BSbOESCyd9FSLKyplPSAANm7Ifs4HoamqGs4/Q9WS4BtxD7bwu
 kJkwL10PNvcBmGyIL7JScjL1MNyWHHHeQGx63oYcrzD4ZJehU7g8Q1r/JFaAtLk5eWVrMqkFP0N
 smdGrl7UmGPRA8TJxBI779EK07y0ZRLqEdoD+pJBBAhEXCc5NXFw+bo5iej0iZS+UpWVMG+FvaM
 a1jw6OeglqI12E9HU3DqsRqCCQMlPGU1Q6jE9HSWPo4xZVGwWCq40Q2TQFw/1e33az9zsAm9XRS
 kpPUyxABpDXrQgy4kCdzaCtTMHflTTAA5aDMK0fDn+DYryucpg==
X-Received: by 2002:a05:600c:5008:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-442fd622ce5mr1958205e9.13.1747326060253; 
 Thu, 15 May 2025 09:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiUy2oy3XdXmoBe7DCzEh8lxZ+2pPgwp6kreianpwrGecgnem5YdxYnPr/50y4tegMMiFwJQ==
X-Received: by 2002:a05:600c:5008:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-442fd622ce5mr1958015e9.13.1747326059885; 
 Thu, 15 May 2025 09:20:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cee4sm23412945f8f.67.2025.05.15.09.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 09:20:59 -0700 (PDT)
Message-ID: <6a558b91-1060-4f16-ad8d-71582bbf3b5d@redhat.com>
Date: Thu, 15 May 2025 18:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] scripts/checkpatch: expand pattern for matching
 makefiles
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-7-berrange@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250515135936.86760-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/15/25 15:59, Daniel P. Berrangé wrote:
> The current regex matches Makefile & Makefile.objs, but the latter is
> no longer used, and we're missing coverage of Makefile.include and
> Makefile.target. Expand the pattern to match any suffix.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4a18daa384..00d7d72e53 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1453,7 +1453,7 @@ sub process_start_of_file {
>   		my $permhere = $fileinfo->{linestart} . "FILE: " .
>   			$fileinfo->{filenew} . "\n";
>   		if ($fileinfo->{filenew} =~
> -		    /(\bMakefile(?:\.objs)?|\.(c|cc|cpp|h|mak|s|S))$/) {
> +		    /(\bMakefile.*|\.(c|cc|cpp|h|mak|s|S))$/) {
>   			ERROR("do not set execute permissions for source " .
>   			      "files\n" . $permhere);
>   		}



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



