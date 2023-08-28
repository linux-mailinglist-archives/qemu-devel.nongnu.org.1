Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C31978BB1E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qakyM-0003xz-KN; Mon, 28 Aug 2023 18:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakyK-0003xZ-KU
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:44:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qakyI-0001JY-DR
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:44:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40061928e5aso34938175e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693262673; x=1693867473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OyyxGce5gmUfNa1tP64bKObZmxdcrbkh1N254wyjdj8=;
 b=k7WAhWeyRVjmbKXoFTMQVOt3rYKxukLD2PzsgVqfbQwXcrICdz3vwOQY6DI0J4dkB2
 C+dQUzNsTOGEJz0YMG+EF0hHw5FZ+U2YHLM98scz5D25xg5iVnE2OspOUk+NE7Pb9V66
 hLwOHjJ76uw6uEDCWrLn3i7MX2bVKryBySPdupmDM5W2qXb+UkKglyC4zvo1R2sZ5hG5
 1zi8jq6nsVTHAEZUUopx15qV+Y39S29UmCmlf+mLv7Dsl/bMkxf3k8SJ2wsV8rKsxh20
 F+0CqkPX4svCnHSKGaOHc4/TzIE3hordRSyYzsrCPwGb6sdcIxN2/hmFFFay9Gc0n7h/
 pf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693262673; x=1693867473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OyyxGce5gmUfNa1tP64bKObZmxdcrbkh1N254wyjdj8=;
 b=Q92x8FrwfGN5+EyrezSxKNTB+bHvEgZBzH2EDlpKId9IuR1ayVY2uQEZrAKB0SNnd/
 a0aX54eJWJDTX5ugxsveus8DqQ4XU3euqsw8d08WAd7tr0jzOyZtrcr3l33C1WfrkEC0
 QQj/b6atk+4aus3qoP3kmITt3sd3HPnlP4QAOe75buNgkMeW/ve7EaZDUDY3Ync+uwH4
 iInPpzoR1FEyWzFUEQGFx/Gj84F6yrZxpJAKslqDoqsprx+XyTSDcSn0+SNCxMDXLlbU
 4xiY3iw28QeY+s99dn24WCgow7T6z3N10ml797JeS7O7QRxyn8wdlCYpKuMeh1p4vGcX
 7UYQ==
X-Gm-Message-State: AOJu0YzQaG6PNiAsOT/cFAqgEeOsz9YoTwuAZbbt0fMUWUNFRHt7jKGZ
 rDyxDTNk9buVeDdxzdt7ALQ4vw==
X-Google-Smtp-Source: AGHT+IHfaSlIx9csx3MxeEpezV95gAFOz7PpYvKzI16bZvPWrAZsdeY5OaE3KOe303ksrNGWCZvLAg==
X-Received: by 2002:a5d:42c7:0:b0:31a:d31:dbf9 with SMTP id
 t7-20020a5d42c7000000b0031a0d31dbf9mr19067876wrr.49.1693262673038; 
 Mon, 28 Aug 2023 15:44:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adff44c000000b00319779ee691sm11852050wrp.28.2023.08.28.15.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 15:44:32 -0700 (PDT)
Message-ID: <f7a42ba7-613b-bc85-35d4-83c5f08c0964@linaro.org>
Date: Tue, 29 Aug 2023 00:44:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 16/16] virtio-mem: Mark memslot alias memory regions
 unmergeable
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
References: <20230825132149.366064-1-david@redhat.com>
 <20230825132149.366064-17-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230825132149.366064-17-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 25/8/23 15:21, David Hildenbrand wrote:
> Let's mark the memslot alias memory regions as unmergable, such that
> flatview and vhost won't merge adjacent memory region aliases and we can
> atomically map/unmap individual aliases without affecting adjacent
> alias memory regions.
> 
> This handles vhost and vfio in multiple-memslot mode correctly (which do
> not support atomic memslot updates) and avoids the temporary removal of
> large memslots, which can be an expensive operation. For example, vfio
> might have to unpin + repin a lot of memory, which is undesired.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/virtio/virtio-mem.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


