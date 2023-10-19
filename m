Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BAD7D0424
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtan1-0007z4-JS; Thu, 19 Oct 2023 17:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtamz-0007ye-4O
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:42:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtamw-00011y-6n
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:42:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32d8c2c6dfdso113664f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697751760; x=1698356560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CgGFLdB2UjYhHH7x5Td1yhJ3+au17bs6VIJjXBBEES0=;
 b=ch1sSOMwgfWRcGz6z6QsWFNwacFNQQAUMpRSzZY9S8qOKGduXYvOoVf5WZsDRnVUlb
 3VPYh2ZfwHctRfby0iGxjy7ueUhKDr1kZ1fqSTfsMkSZI8nvxmQnqCkVVxBjdoPQIx1v
 bK0fcKLPMgBv4uEoXt6FWkMAHg0amKuU1xDlfWByrJoviqjQ9gS19VsfuBEt7w/W9k+I
 Q4euoUph86Gn5bSCHqs78LLFB2RP6Z9qBX7GWoimOEFu4gh7Dne85iiyNiUznfykBXqx
 YJCshFnpJ1Xnv8PtyZ7u5tvYu2i9/b3iCVr0OoQFgAPMu14uEQVYUVLMgL3SrDLyDxOW
 7lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697751760; x=1698356560;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CgGFLdB2UjYhHH7x5Td1yhJ3+au17bs6VIJjXBBEES0=;
 b=KA/GuJuw7h0Px2GQGK+9Wmf7QijbrfGdzsWwxWHBKBkSafjAGTYtuRs8GhifCOhN6k
 Ibfqe6U3ygQdKhtLs0cna44RWtd2TGpOTldhqN2vwWrcSK18njJoGTfousYJmTrNMRhV
 BhESO7USWvZ0cTq1nNXuYIYhVfdZcUqv4QZswFYAygQtGp9gRCvVj/XvG+cYq1qhraoj
 5zk9NHVJH4/nsgQlLdADeD1TiPWqurVnOpXECclo+Hah8kTiuRzMK7KDj66Qm/lsJmco
 nFapLdAwoNuiXtjv9epXLpSZx4Eb6HmtXa8zEyDWcDLZ9Ml7PwWu5pjp7c1ipYy/mouf
 S3tw==
X-Gm-Message-State: AOJu0YwfjIGCGlEVeb1vCqB1+Q4arHrDg+xFO6XGonq1dw9ChRrhVWpK
 406qC4ymdNMRRJ0MH+7uPu6cS+G66x5BpQw853wBPw==
X-Google-Smtp-Source: AGHT+IGa6uCULyaquoR1VVw2k/HuDCIZYobvq1VdGXpM+bHQOgoWPOOREcEg9CizBVKfc4xXQ/3JGQ==
X-Received: by 2002:a05:6000:a:b0:32d:9335:f49a with SMTP id
 h10-20020a056000000a00b0032d9335f49amr18702wrx.39.1697751760554; 
 Thu, 19 Oct 2023 14:42:40 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 u14-20020a5d468e000000b00323330edbc7sm260447wrq.20.2023.10.19.14.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 14:42:40 -0700 (PDT)
Message-ID: <96390503-eb2f-cb30-791b-c38df001397b@linaro.org>
Date: Thu, 19 Oct 2023 23:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mailmap: update email addresses for Luc Michel
Content-Language: en-US
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20230929140326.2056658-2-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230929140326.2056658-2-luc@lmichel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 29/9/23 16:03, Luc Michel wrote:
> Map my old and now invalid work email addresses to my personal one.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
> Please ignore v1 sent with wrong e-mail address.
> ---
>   .mailmap | 3 +++
>   1 file changed, 3 insertions(+)

Thanks, queued to hw-misc.

