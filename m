Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 930C67F2B29
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:00:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5OTw-0000h8-U9; Tue, 21 Nov 2023 05:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5OTs-0000bs-JB; Tue, 21 Nov 2023 05:59:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5OTr-0007Dp-06; Tue, 21 Nov 2023 05:59:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4084095722aso26655115e9.1; 
 Tue, 21 Nov 2023 02:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700564382; x=1701169182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0aBbFlNNIGjyQCXLjrh92AJeZxwPUBKAFPiK1JRzuDE=;
 b=gfPvsAxZsIFmysun/+RKyDHRlcbhalra5lg8S2lYR3OkfTk3WoSQjwKHYOBP+upqcM
 pc2wSC07KAjjHf/WLpvLT5VDHt2Bug/3AaRXhTsIs2ItlJT+03B8QmMs8eYxFMsRmn36
 qFAykZktXjV4+2tm+bsdRBiUJzDDSVYt8058p8dYWganNGSHOGhNwCPDL7C0TX2m8Z0W
 pA1KEQb4kiuHqNAD+UhLleQ/An8+PVPbdycWqPgLhpT60+JCU28GSwSEZ18elld3yrpi
 P4FFRnB7YHn5q+1wwMUkyBk7h0izRMVv9ndrypJzmaeiU5qI67rCHemy5qyxWqFH5PIq
 HyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700564382; x=1701169182;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aBbFlNNIGjyQCXLjrh92AJeZxwPUBKAFPiK1JRzuDE=;
 b=M2OodzHjHwsoCjsl4IjrW4ZIhPdf6knFqHuQXu4XcDJS1NrPHqaWL/cMEXnwyHhd4d
 +iLlrC6h23yAKcs4FYfTN0fRiI7DSx3mjEr12XFISl4bpGveyK3/ewgssfqPVrzgESct
 2mAWMZCiLJnFkjQRl/tpj71NgZ6AHNKzM+Wb5hQPG9v5lxfFRyBJrb/EVGzDpNh8/2MX
 DJLXXp5s9j8yp4uGeymzSGw2ai27gd0dUsCkpsMFnASpGagBcrDit4O23oPaGxh2mj6x
 tHHjccmQgTRFrwpMdQQiB7x+QMihWHUt13zqH4cYFgsn2IErnM/01MnBEYbvgrg7GIyd
 eqyg==
X-Gm-Message-State: AOJu0Yw+k3f1iy/KWtCWgi+XdTgigA9yp3CPTuIHMY8eRKc0WBtcekjh
 69a2rR2Xdq4EnJh5soLaAXM=
X-Google-Smtp-Source: AGHT+IGlIetHxet5t4JoCfSOc3aRa0aU712VgafZ6O28U+VrbIAHSvlMGOBLHgze6oP5stvgX5rjlg==
X-Received: by 2002:a05:600c:1d23:b0:40a:4c7e:6f3e with SMTP id
 l35-20020a05600c1d2300b0040a4c7e6f3emr8048958wms.21.1700564381817; 
 Tue, 21 Nov 2023 02:59:41 -0800 (PST)
Received: from [10.95.175.211] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c429500b0040a4cc876e0sm16479782wmc.40.2023.11.21.02.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 02:59:40 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <edeb4a60-0011-41ed-9998-25ab1a439b62@xen.org>
Date: Tue, 21 Nov 2023 10:59:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vl: disable default serial when xen-console is enabled
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
References: <20231115172723.1161679-1-dwmw2@infradead.org>
 <20231115172723.1161679-3-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20231115172723.1161679-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 15/11/2023 17:24, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> If a Xen console is configured on the command line, do not add a default
> serial port.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   system/vl.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


