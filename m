Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3F7939A6
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 12:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdpad-0008Eh-IF; Wed, 06 Sep 2023 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdpac-0008DZ-1E
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:16:50 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdpaZ-0000WH-Gr
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:16:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso4973914a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693995405; x=1694600205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DPijZUyjSTFtnwDko+hOZyDniiH6bpnrZgQlycb/bJs=;
 b=IwKYUJI8BCzReY5ABjJ2nKo/dyuqUcoMa1/huloROsK2mS/M9ewO9cFv6rbdas9s7l
 1CroMzNWIrGDlPPFJB71frh+oWkr3PB1PT0uHQccG3f3EDDlxeXZ6LuWp66g8BLa85b3
 96DoUjidi+jQekvHtIQJdR2jsY4xJrPOw4FGj+b0veEmehzQUXob0ycfM4+yiOpHn87v
 5ThsBcq4/xRFo9apnD4ZH5jcP+Qm0hWnOCSKAfIftz/zeKQ9DAcIBb7hLPYVhULL1XYd
 qalAoqhvQr8p8RyQCp3FrGURxCc5zXiqBJ2moKuG4DFIhYNwTNBG1XTGOo2qhQBgEpJB
 zpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693995405; x=1694600205;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DPijZUyjSTFtnwDko+hOZyDniiH6bpnrZgQlycb/bJs=;
 b=FXnPwXs11cRRQTTZVpMdUgdoqPdlLQyrYmlkeci3qTejpxnf1eYBkLShDgpA+FdUB6
 /mcAQepQKJDzQry7fy8w849FfmYixlA/RRb4PsAfDLy3iR4ewNnueMWJEoc+AH+6G+RY
 mTlwTwRo0Ugvf20oVcUYF/aUl9we2Txx4DpdDiJnUeBtkf6pcNiZO6tnbDT0GsovFUKJ
 5VnJerLNSNM7qjTJv/L35neeMlaxN/ebyRqy/Lb1U+Vdv6Ud4966+ujyn1loKxPlWQon
 smVG4lYRKTXS/9RcHMUOAEQnI54QkyjglVS3zqOtH3KRF1nPcZ8FsdbSFAkAbD17MexL
 Nl4A==
X-Gm-Message-State: AOJu0YxhcbEK1s3YIcTT7qmCHgnNRz5OOIq2I89blRfl+XQjn/3QJ1pC
 YsP4iam37Il8ruwP8DTRbpS+fQ==
X-Google-Smtp-Source: AGHT+IGi7w1sCWpNMkwZuFQiTjTjhudG6Y9MjAiGtnegRkBN0VlktP+KcSic2wpCd0splYA91JjjKw==
X-Received: by 2002:aa7:c245:0:b0:523:102f:3cdd with SMTP id
 y5-20020aa7c245000000b00523102f3cddmr1828412edo.19.1693995405158; 
 Wed, 06 Sep 2023 03:16:45 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 d38-20020a056402402600b0052cdc596652sm4635215eda.23.2023.09.06.03.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 03:16:44 -0700 (PDT)
Message-ID: <4003277a-bb3a-bf90-d23d-78ebaaa02564@linaro.org>
Date: Wed, 6 Sep 2023 12:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 0/4] Virtio shared dma-buf
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@gmail.com, kraxel@redhat.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <CADSE00JRMvQ6Ye445xon0GoCDSsp7oAY_B--rABooabMTraoaQ@mail.gmail.com>
 <20230905164451-mutt-send-email-mst@kernel.org>
 <2b6df154-de47-ab4c-d315-a541935d1276@linaro.org>
 <CADSE00LRBomBNM9tKRgaRH_T7Xj6p9_Nz2y1mNFF_AZ8ivQbfA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CADSE00LRBomBNM9tKRgaRH_T7Xj6p9_Nz2y1mNFF_AZ8ivQbfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 6/9/23 11:39, Albert Esteve wrote:
> 
> 
> On Wed, Sep 6, 2023 at 8:13 AM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     Hi Michael,
> 
>     On 5/9/23 22:45, Michael S. Tsirkin wrote:
>      > I was hoping for some acks from Gerd or anyone else with a clue
>      > about graphics, but as that doesn't seem to happen I'll merge.
>      > Thanks!
> 
>     I made few late comments. Patch #3 doesn't build (thus
>     break git-bisections). I also have some concern about locking.
>     I'd rather see a v6, do you mind dropping v5 from your queue?
> 
>     Thanks,
> 
>     Phil.
> 
> 
> I have the v6 ready. I will wait for Michael response and post it,
> to ensure that I do not step on his toes.
> Thank you both!

If you have them ready, don't wait to post them, because:
- we can review them
- Michael can directly pick it instead of dropping the current
   one (you'd have to wait his next PR)


