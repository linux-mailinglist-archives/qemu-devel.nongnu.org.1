Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F21F57E9770
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:16:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2S68-0003A2-2j; Mon, 13 Nov 2023 03:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1r2S62-00039u-SN
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:15:03 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1r2S5z-0006CU-9v
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:15:01 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 9434540F1DC8;
 Mon, 13 Nov 2023 08:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9434540F1DC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1699863272;
 bh=l29EjPaC7o5OzZgVKtoLNP+JnfmnHLHysiBsAEAhuiU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BgGiILNqWLRYWd9PDfOxtFNVc/mqgpRVH9DkYYWi/luSN9sXBmaHowrNKeIYKvu5p
 K2otbqKB+jm1nMJFFG+XxMkbHHuytJh+AQH/rMHDGcCF0Up4zrFyHOxQTXlCpKWd9O
 aGLaYAtWT4yFF46HMIwpZKoW9tcNfx7EsurR9HGM=
Message-ID: <b450ddee-3b47-4380-b39c-2cecc284c932@ispras.ru>
Date: Mon, 13 Nov 2023 11:14:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/21] net: Remove flag propagation
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-7-akihiko.odaki@daynix.com>
 <44477e7d-c3a6-45d1-91e0-217306d97673@ispras.ru>
 <595f9067-a9e1-40c0-8166-70b670723681@daynix.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <595f9067-a9e1-40c0-8166-70b670723681@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11.11.2023 17:27, Akihiko Odaki wrote:
> On 2023/11/10 16:35, Pavel Dovgalyuk wrote:
>> You need to bump REPLAY_VERSION in replay/replay.c, because your patch 
>> changes the replay log format.
>>
>> Otherwise, for replay part:
>> Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> 
> I'll drop this change then. It's just a cleanup and does not bring an 
> additional benefit worth breaking the log format.

Breaking the log format is ok, because replays may be incompatible for 
different builds, because peripheral or vCPU behavior may change.

So bumping the version just helps with not replaying the wrong log.

