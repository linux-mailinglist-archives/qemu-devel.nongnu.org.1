Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF577CD3C5
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:01:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qszbq-0007EO-NZ; Wed, 18 Oct 2023 02:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qszbV-0007Dm-O3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:00:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qszbS-0003uZ-9W
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:00:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso8053545e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697608820; x=1698213620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=X028/fd8DrXxUtf65Rf40WtHUyqlHMYDA2eqBVeJOKY=;
 b=RiKVK95mIlI13AFZOyqbV88ipgRiNTcNfh9/8C1YJkNPRMKDBWzVm2FCHzem/MidZu
 ir4/IlvKs4SaqRUpZUP8/doeX0mnhxMBPonk499MmXYviW1ahn+P3M7mcmJBDXtwqxKA
 1JfwTBrq0kYne6Y1HBiCBefMTHagDToY6PPyOkS+f+D88KE77n1NjhSLNEXflAmbAK1m
 PxjNVl/5eUCKRefsVyPhOjbTNBDA504ETr8TAScVlqCpZW1hH/MGFA8BPPwn57wauwDZ
 B/9Fn4DxQLwhGa0VUvd+siqWsE7j1H/4IZtScocy/eLO3zkqZd6JAucYimnUZ/k2Q7ah
 Lyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697608820; x=1698213620;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X028/fd8DrXxUtf65Rf40WtHUyqlHMYDA2eqBVeJOKY=;
 b=AuUnWV4zIoHtnoYNTY50fSrUCd93YPURgKcT0NChMnGFBkjyzrQOqdaAXz/EEMbElp
 LwDHZKfCKhBhAD6X+AgjiCIPuWWOu6WId+pCj+Vd5RxzAt2O4w+oFAtR39kfrgEJKKZT
 Kd9kkSyx56/xvdvtJ3vStcjIppda7l7uaByO24MW/323jsh5oyANDSCQtzF+UiXqSPVJ
 NHWMUduXeKaPF3lGNb2AI1LSsamKEJoMNq5FHkiHieUh1yrBIUmKvmzQ3GxBuvWq/yAe
 1qWJ3L/ZG90cCgqWAypGzrHxDSdmYNUPTQoT9j3l7q26cVFKwce8pWK1uYs/gSp0j8nQ
 gaPA==
X-Gm-Message-State: AOJu0YzTw6tkjFeevjpV8hblMZCPNY/eDWpgRoMwgANADUyvWfo7Ssdu
 ME58iOUxu+wVwNAGajxaU00Amg==
X-Google-Smtp-Source: AGHT+IFumBUTSshHy5j9Mu/AO1uOMLN3dhTRRosJSGMWFB+8lyOV/7BJPlt2e+mE7HG3pL+w/kcrRg==
X-Received: by 2002:a05:600c:4c08:b0:407:73fc:6818 with SMTP id
 d8-20020a05600c4c0800b0040773fc6818mr3719701wmp.2.1697608819711; 
 Tue, 17 Oct 2023 23:00:19 -0700 (PDT)
Received: from meli.delivery (adsl-21.109.242.226.tellas.gr. [109.242.226.21])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a05600c350500b003fc0505be19sm721691wmq.37.2023.10.17.23.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 23:00:19 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:50:22 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Jeff Cody <codyprime@gmail.com>, open list:Block Jobs <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH v2 02/78] block: add fallthrough pseudo-keyword
User-Agent: meli 0.8.2
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <e54aa70630d6d524886d7950b84d5bda39c3d605.1697183699.git.manos.pitsidianakis@linaro.org>
 <7efwgbjschmbjc2fjzuvwphwtl5ltfjydkvslctr5tfh6g7mqb@x2hf2cgps2yb>
In-Reply-To: <7efwgbjschmbjc2fjzuvwphwtl5ltfjydkvslctr5tfh6g7mqb@x2hf2cgps2yb>
Message-ID: <2pncg.iakee0lfrnfs@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 18 Oct 2023 01:11, Eric Blake <eblake@redhat.com> wrote:
>>  static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t 
>>  l2_entry)
>>  {
>>      switch (qcow2_get_cluster_type(bs, l2_entry)) {
>>      case QCOW2_CLUSTER_NORMAL:
>> +        fallthrough;
>>      case QCOW2_CLUSTER_ZERO_ALLOC:
>
>Why is this one needed?  It looks two case labels for the same code is
>okay; the fallthrough attribute is only needed once a case label is no
>lonter empty.
> ...
>These two also look spurious.
>
> ...
>but these three seem spurious.

Thanks for pointing it out, Eric. Indeed these are mistakes.

By the way, there's a newer version posted [0] because as you noticed I 
accidentally left --function-context on git-format-patch and didn't 
notice that some of them blew up in size.

Also, the consensus in v1 was to reject this patch series in general 
[1].

[0]: <cover.1697186560.git.manos.pitsidianakis@linaro.org> 
https://lore.kernel.org/qemu-devel/cover.1697186560.git.manos.pitsidianakis@linaro.org/

[1]: 
<CAFEAcA_fLBe9CuWFYpeuejj8dcerhFtPNX+iVaVFvH4SXx1oAg@mail.gmail.com>
https://lore.kernel.org/qemu-devel/CAFEAcA_fLBe9CuWFYpeuejj8dcerhFtPNX+iVaVFvH4SXx1oAg@mail.gmail.com/


--
Manos

