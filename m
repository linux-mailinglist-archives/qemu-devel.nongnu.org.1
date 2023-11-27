Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 002097FAA15
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 20:17:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7h5I-00047u-CY; Mon, 27 Nov 2023 14:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7h5A-00047V-Cz
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 14:15:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7h52-00061T-Sr
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 14:15:47 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-332f4ad27d4so1643303f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701112539; x=1701717339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QlOsSWunqmdLKwNn3FGdD28oDMnz42jXzgI/twKk9Yc=;
 b=fr+SHzeG4abXyFnwsj7unaSXxX7E7/Vl8m4xdu/Ju5fBW46vsRiem7kFP8WYjymWSg
 F0/6rwH6Xay2mU1qjQeS2D/X3Qyr/M7Wj0IuCSixMd8T7mJ0mFLw/rKSXjE4GBKd8Z5Q
 40Njo5O+kPtc/Zu0DwqmETN+Ain2CLBfNg809+/EergPxiDg4LOpE3dB5LIM0ASFIKls
 x2BKi8TfMUwQbeVJd9oGlOHcsiIa2xGjvWfu6pESbR3YwbvSHS8m1spu8NY4QAXPVscg
 UhkVkZkV+V8SWbExRDTzGSIU4N+JzCgRqdyxJK82s6k+TFlkXFlUdO/7R20rcOMJo7Wv
 V9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701112539; x=1701717339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QlOsSWunqmdLKwNn3FGdD28oDMnz42jXzgI/twKk9Yc=;
 b=PTwWGriOBaZ8bF4BksJWdkiAhsUMLr93APibMToyhKwI4kQIVOiS/bNdY5Wx2qRQjZ
 ISvQgzCU++8aSvRqUEeDnYHHKoltipdHakyZ8+TxhtWJHPX1C1VfEQybhgX0Pt6pOn81
 kCVaMr4QNKKiS/bzBpy6sksG7RZCmBnLzfK+eRZlkqmGqzIdk9J+L0ySLkdfTrgLfoiG
 CEryRTXEQD71jCJ+tQWEigSV6NGIVyJ68ED1BuqoAgUyTYnl88pzJhqalTn6xfR2B30d
 8gQL5kLjnAG+zBKMbq8zZ0NR5NWVHvlwxDwcPNzGfIfzBODHCRK1zX24EeXyRf/uK6by
 flQg==
X-Gm-Message-State: AOJu0YwhGCKf5Ze5Sos8M46ZBMOydTEMKi9MOUMV/LZ/EiFLehZUvXrN
 X2pxjDkp6ZqWgDlblEUBnovk2w==
X-Google-Smtp-Source: AGHT+IGjJVvJYZphlNWRGYxAqluFcVhjh5ladosjlO8SYUhlvqlsCDa4KpciTdQwyN0c7GEO0/7ntA==
X-Received: by 2002:adf:ec52:0:b0:320:8e6:b0cf with SMTP id
 w18-20020adfec52000000b0032008e6b0cfmr8292945wrn.42.1701112538646; 
 Mon, 27 Nov 2023 11:15:38 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.101])
 by smtp.gmail.com with ESMTPSA id
 x1-20020adfec01000000b003313e4dddecsm12825278wrn.108.2023.11.27.11.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 11:15:38 -0800 (PST)
Message-ID: <2c794194-add0-43fc-bb8a-e90d2c6b263d@linaro.org>
Date: Mon, 27 Nov 2023 20:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: bios-tables-test: Rename smbios type 4 related
 test functions
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20231127160202.1037290-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127160202.1037290-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27/11/23 17:02, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In fact, type4-count, core-count, core-count2, thread-count and
> thread-count2 are tested with KVM not TCG.
> 
> Rename these test functions to reflect KVM base instead of TCG.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   tests/qtest/bios-tables-test.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


