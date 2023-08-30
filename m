Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E78178D494
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHZH-0006TY-Cu; Wed, 30 Aug 2023 05:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbHZF-0006Sd-FV
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbHZD-0008NG-7b
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693387970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42m0K1Psw3EyMR86A6Ga3oCxl4vSyD9VE1p4LBtZlQQ=;
 b=ENDFT+0JpmuaVD+SBsccXbc1YLMgnC6QhzdV0b3a45mnKf8Fp4V2V5k45g4wRGy+409TKM
 91S/ajO3bZB3v9DvLiSAKaHb6tJT49FpsoLSB6uUpUiJFCDO8Js/JlV97GJRa+vUkdmAHr
 Q/fbkUnVaVKSUSuRF4FJVgWqtqB/hZM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-AJmeTJhtOQuBvmmf3YMk1g-1; Wed, 30 Aug 2023 05:32:48 -0400
X-MC-Unique: AJmeTJhtOQuBvmmf3YMk1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DCF83811F3C;
 Wed, 30 Aug 2023 09:32:48 +0000 (UTC)
Received: from [10.39.192.65] (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDD4A2026D35;
 Wed, 30 Aug 2023 09:32:46 +0000 (UTC)
Message-ID: <b6bd7ea9-2dd2-eef0-6612-d7e617c8a5f3@redhat.com>
Date: Wed, 30 Aug 2023 11:32:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <3hc3j6klx6f3wveap72mebb26iratugg5z64ol3xikt3zigiyh@fd5yilpjuq44>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <3hc3j6klx6f3wveap72mebb26iratugg5z64ol3xikt3zigiyh@fd5yilpjuq44>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/30/23 10:48, Stefano Garzarella wrote:
> On Sun, Aug 27, 2023 at 08:29:30PM +0200, Laszlo Ersek wrote:
>> The last patch in the series states and fixes the problem; prior patches
>> only refactor the code.
> 
> Thanks for the fix and great cleanup!
> 
> I fully reviewed the series and LGTM.
> 
> An additional step that we can take (not in this series) crossed my
> mind, though. In some places we repeat the following pattern:
> 
>     vhost_user_write(dev, &msg, NULL, 0);
>     ...
> 
>     if (reply_supported) {
>         return process_message_reply(dev, &msg);
>     }
> 
> So what about extending the vhost_user_write_msg() added in this series
> to support also this cases and remove some code.
> Or maybe integrate vhost_user_write_msg() in vhost_user_write().

Good idea, I'd just like someone else to do it -- and as you say, after
this series :)

This series is relatively packed with "thought" already (in the last
patch), plus a week ago I knew absolutely nothing about vhost /
vhost-user. (And, I read the whole blog series at
<https://www.redhat.com/en/virtio-networking-series> in 1-2 days, while
analyzing this issue, to understand the design of vhost.)

So I'd prefer keeping my first contribution in this area limited -- what
you are suggesting touches on some of the requests that require genuine
responses, and I didn't want to fiddle with those.

(I think your patch should be fine BTW!)

Laszlo


