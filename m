Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3358793D6C
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 15:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdsGF-00074l-Ei; Wed, 06 Sep 2023 09:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xu@linux.dev>) id 1qdsFx-00072X-FB
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 09:07:41 -0400
Received: from out-228.mta0.migadu.com ([91.218.175.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xu@linux.dev>) id 1qdsFt-0003jc-HK
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 09:07:41 -0400
Message-ID: <5e6b1bbd-bc0a-cff5-119c-639a9d15e72a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1694005649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGoDnKeHLbn6LihaQjYmsdl+qed6fld3ewWmJXgDQDU=;
 b=xa084eLAUybsKxGSZqgPfzGKgn30InWq1ZMFDYcOHLf7JVDhr74CnZnDqTaxo/XVhmOTZw
 07mKD8SjLlIBHr3n7KO5VYB06CUz5CV/7jElBYg+dnb1qMccnOY/3d5AZIjjcTQjxRUvRE
 41W9qWxSxddUwzkzS2a7G/zUWErcZ74=
Date: Wed, 6 Sep 2023 21:07:16 +0800
MIME-Version: 1.0
Subject: Re: [Virtio-fs] Status of DAX for virtio-fs/virtiofsd?
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: virtio-fs@redhat.com, Erik Schilling <erik.schilling@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
References: <87v8grlzu9.fsf@linaro.org>
 <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Hao Xu <hao.xu@linux.dev>
In-Reply-To: <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.228; envelope-from=hao.xu@linux.dev;
 helo=out-228.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


On 5/18/23 00:26, Stefan Hajnoczi wrote:
> On Wed, 17 May 2023 at 11:54, Alex Bennée <alex.bennee@linaro.org> wrote:
> Hi Alex,
> There were two unresolved issues:
>
> 1. How to inject SIGBUS when the guest accesses a page that's beyond
> the end-of-file.

Hi Stefan,
Does this SIGBUS issue exist if the guest kernel can be trusted? Since in

that case, we can check the offset value in guest kernel.


Thanks,

Hao


