Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC347E8B35
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 15:29:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1oxh-00057H-HL; Sat, 11 Nov 2023 09:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r1oxf-000575-TA
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 09:27:47 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r1oxe-0001Zu-5b
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 09:27:47 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6c4cf0aea06so1958670b3a.0
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 06:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699712864; x=1700317664;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V7JHFKYdzDBqfo8x5oJC31Ytwl3OwjDF0rqtBLbMLpI=;
 b=BayCrB3U9nEmRkFtxjjDjqFTdZ0Mb67+cuuU4R6Hqfm8IF47vSdZsWV0NOLWL6bkCG
 e/F/U1PSEwah1WCmejuCuY6CjrUcMruZZyryK/bafl7YxvFvd9KsZfQLBkoLftvp4/O2
 tmMhX7fNQX77IfLqkYB1qg/J0P3pVB1zQlSVjp99hhDcZ0NKPq9kdpnkSmSHLCzh3GA4
 ORraPtxDlaqyvY8xqt4P8JhDExDPOdNJLNIteh9io430cMNEXKqxpIOEfeU6xdrlYe7l
 BcYaVRZ6smXvJB/ItxB8FOZBsjzGAnOEe5025AFiC4O/QV6IfctGzp3EB81n2uRWMyt5
 P6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699712864; x=1700317664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V7JHFKYdzDBqfo8x5oJC31Ytwl3OwjDF0rqtBLbMLpI=;
 b=FJtq+if6hP1xjRnfhHvtEwIaW4rV9Pk/RjbtbOyKZH8RwrBBogphSVjdx+rrxwsxM9
 ZPCz3LWnhR+VHX6ABypUn+mOY4Bdp9fESZ/A8kS4s06WKPMm184GtlNWIjHglsXNJdsB
 ktht0tFhvQdMTcDJrev3pAfROSGEPdJlUwVHJI/6BVeNUQ+OO5Wui/fyHd8usrttMN8K
 ybA1tWLHHEH8rZ7NYCLx7g+bCBlrN0iUonNnM9YEkEaHrzNV18VnsipsUcELwZz6jmSF
 LAdfUc6/9SeHE4UIvRiwTIFFsYpDXBWsQDSCGtIH5V4Vf5ByXz6hH4cjV11IGKQII9sd
 beqQ==
X-Gm-Message-State: AOJu0YxJROQ5neMI2pjD92yvTnG9THGYMO5tQ+DpsoPN9Aj3WxDNwUxU
 fKjpY896RZZOAVz9rB9SCUhzLA==
X-Google-Smtp-Source: AGHT+IGVoP1kakkJG/DLsma4FOatJMkdfoN9b4w/c8V5wTgcFrSaEEsqX8I/OTL3hyF60d8Oa8W6Pg==
X-Received: by 2002:a05:6a20:d417:b0:17e:70fa:3f3c with SMTP id
 il23-20020a056a20d41700b0017e70fa3f3cmr2252637pzb.57.1699712863976; 
 Sat, 11 Nov 2023 06:27:43 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a056a00175000b006c34a04c782sm1360771pfc.61.2023.11.11.06.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Nov 2023 06:27:43 -0800 (PST)
Message-ID: <595f9067-a9e1-40c0-8166-70b670723681@daynix.com>
Date: Sat, 11 Nov 2023 23:27:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/21] net: Remove flag propagation
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-7-akihiko.odaki@daynix.com>
 <44477e7d-c3a6-45d1-91e0-217306d97673@ispras.ru>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <44477e7d-c3a6-45d1-91e0-217306d97673@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/10 16:35, Pavel Dovgalyuk wrote:
> You need to bump REPLAY_VERSION in replay/replay.c, because your patch 
> changes the replay log format.
> 
> Otherwise, for replay part:
> Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

I'll drop this change then. It's just a cleanup and does not bring an 
additional benefit worth breaking the log format.

