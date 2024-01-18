Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19E831E69
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 18:29:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQWBk-0005AG-B8; Thu, 18 Jan 2024 12:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQWBi-00059W-HT
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQWBd-00066O-Uz
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 12:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705598896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ngKtQtiD8CwOjgPHTOCLDnDCGprLg5N7e3GDH3DXT5I=;
 b=gFrfTjvlEEBDt5vN6Suwex4Xne9ucoMlxK88wxvkq/zTH48fqvCpAYF4F/XOuZqfRM2oKf
 3cvjLOksBHja7uaT1fHGzldou2gnJGWpAOBv32Th3in3XkJ3rMnie2t6YNf8sgQHQxyZUD
 vTpxRa236vwCsvWZKVcgs1iwRNid4dk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-G_zNt3-yMyahMEWvfnpkhg-1; Thu, 18 Jan 2024 12:28:14 -0500
X-MC-Unique: G_zNt3-yMyahMEWvfnpkhg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2e66e65f6aso164058266b.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 09:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705598893; x=1706203693;
 h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ngKtQtiD8CwOjgPHTOCLDnDCGprLg5N7e3GDH3DXT5I=;
 b=nYHNjyz8DCOve6HRgcmJC2AAhJQZHteO1CaeaExopeBJULzckWlB5xG6Cu581UCSyH
 Xy6Msnkf/d1neYMFf8CdXAVHnpTo42k9S3oD31GwAwcY+mJjwqI3E7EdyiNxEImlAqCL
 OkntNqqzxAsf/etx8qTn2kDZxHWQbjb6it672zULK3aRrRPo+kWOEM38tMAeRBL9alIe
 7NXA9wdrl2KYruHbZRBW1iInM1x/vDi1yLMZfXRrqKX9igUzEcHiULLts2A6WNevidVL
 ciYaCQY6gxcjOiQdl7f3QTdJizUyywEWZj2AtNYnFMMWEnKxyIl7MvmZ8k2Dd8c/tCpI
 I/Hw==
X-Gm-Message-State: AOJu0YwpL7cRJqMpORUDEs0Nz00YWVaV78ZTb0VkRPvNANscpwpsBbCo
 QqTRtCEanf3F1rkXEtRkEzA6bOl+JCzwdzV8UEWPRpLzWt+qRp/tiY98fj6oLL1/s2SZFWInFsc
 IjiACShZqP9Esw1TjYL6Wp7o3P/GjdHakSV8XuvRPipeVtDMunq0q
X-Received: by 2002:a17:907:3c02:b0:a27:5446:27d9 with SMTP id
 gh2-20020a1709073c0200b00a27544627d9mr572334ejc.5.1705598893587; 
 Thu, 18 Jan 2024 09:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1CO2RUREJnIQVrOsjG6viYNHjWJOdQdi0vXQCN3wOJCEpAkoVdJe9+h5FQ+ZSUp2KuUf+kA==
X-Received: by 2002:a17:907:3c02:b0:a27:5446:27d9 with SMTP id
 gh2-20020a1709073c0200b00a27544627d9mr572327ejc.5.1705598893336; 
 Thu, 18 Jan 2024 09:28:13 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 a5-20020a1709063e8500b00a28badcf367sm9337140ejj.54.2024.01.18.09.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 09:28:13 -0800 (PST)
Message-ID: <d590988e-faa4-42f2-ba44-45fc08f1851d@redhat.com>
Date: Thu, 18 Jan 2024 18:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/s390x: Emulate CVDG
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20240115202308.1930675-1-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
In-Reply-To: <20240115202308.1930675-1-iii@linux.ibm.com>
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

On 15/01/2024 21.21, Ilya Leoshkevich wrote:
> Hi,
> 
> Ido reported that we are missing the CVDG emulation (which is very
> similar to the existing CVD emulation). This series adds it along with
> a test.

Just FYI, your patch made me curious which other instructions we still might 
be missing from chapter 7 in the Principles of Operation... with some shell 
scripting and manual fiddling, I ended up with this list:

0C	BRANCH AND SAVE AND SET MODE		BASSM
0B	BRANCH AND SET MODE			BSM
B21A	COMPARE AND FORM CODEWORD		CFC
B257	COMPARE UNTIL SUBSTRING EQUAL		CUSE
B263	COMPRESSION CALL			CMPSC
4F	CONVERT TO BINARY (32)			CVB
E306	CONVERT TO BINARY (32)			CVBY
E30E	CONVERT TO BINARY (64)			CVBG
B24D	COPY ACCESS				CPYA
EF	LOAD MULTIPLE DISJOINT			LMD
EE	PERFORM LOCKED OPERATION		PLO
B9BF	TRANSLATE AND TEST EXTENDED		TRTE
B9BD	TRANSLATE AND TEST REVERSE EXTENDED	TRTRE
0102	UPDATE TREE				UPT

There are some additional ones from the "Guarded-Storage Facility" and the 
"Transactional-Execution Facility", but these are optional AFAIK.

Some of these (like UPT) really look like sins from the CISC past, I guess 
we'll never need them for running Linux guests :-)

  Thomas


