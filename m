Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD27E363A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:04:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0H3W-0003YK-1x; Tue, 07 Nov 2023 03:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0H3R-0003Xq-6N
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:03:21 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0H3P-0002Xd-9h
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:03:20 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso6508314a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 00:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699344197; x=1699948997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOybvJ9RVX6rS6SZ9BCFh/ltl5QB98T/R5z9eZSRl+Y=;
 b=T82mow6hUK+CIdVGKt7rVDvL8xtEg8Z8cPz9Zb14yqfYl29wZOihEYDcnbP6ITiK1I
 RtZ9bA35+dso2nIF4+ab4hK5xM9+m7EMbVn1YKMeiIimmTHTPj+czRBh1HCoOgzDT0u1
 xeu85IC5iaPvZitWD0Wjx3X/+Q5QyYRqQvwkLRpSEmliRsQLexFRjDgojry0ykbUoqIu
 Vq11ZG3k/Ok2A3u9nyERY/GDoUYsUPpQ0KdOf+L9ZgFZ7iYsdtm0aQ8MPZmfD+DIPFuJ
 ZrNCFUwXm8gBkSCuNHvMUSFnF/6b25B+kXGMGwOo9ZZ2P+Plt8/xnIB7IQVl2G8jmG1I
 Mc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699344197; x=1699948997;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yOybvJ9RVX6rS6SZ9BCFh/ltl5QB98T/R5z9eZSRl+Y=;
 b=q6Fp6vmzHDY2IGwOZ2hZXwJeaa6HAp5l+M7XzRKApwhH7FYOXVANQDidEM4E/pllHg
 ZTSCMGYfaO1c7A0n8vOCIyI01AVLwkFWaHj0l3wurQFLs8SvxjRZi5G6B4mTwCmkfGnM
 sCBTQWidSM5OdhIPX2oMNlaILbbJ3Jiin1ap5JkRDCPvBrMqUS8pwOs+o7aqvmGw9znA
 9KPFCo5ndN95LcY+lIP8Jm8RLSvg/gDdn0JQQ/hHcrzno0lMYWeWSp5Vd4VkzaArr4R1
 pxrgBwCWJ0E1Aaf2C82eoVouumAUXI1Hh6/EWp6NmdIMXcxnxCaJT63r/2oPF57rgfZJ
 CvtA==
X-Gm-Message-State: AOJu0YxEuTB/2KS0w94WMTaoEN4sDDCDS7XhWx4w9yyb+BsKQhcZ2U7v
 wPIh5BhYRLAKszJYPYwzuUw/zw==
X-Google-Smtp-Source: AGHT+IFMrQUuWk9hcLIc5/OoSOlNq69HxkNBJU7wDDbvLC6EXGjeV4mfO3QObVo7dcWfEM6UwCK14A==
X-Received: by 2002:a17:907:987:b0:9e0:2319:16f0 with SMTP id
 bf7-20020a170907098700b009e0231916f0mr5035645ejc.65.1699344196972; 
 Tue, 07 Nov 2023 00:03:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b004064e3b94afsm14919479wms.4.2023.11.07.00.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 00:03:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C5825F790;
 Tue,  7 Nov 2023 08:03:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-block@nongnu.org,
 Markus Armbruster
 <armbru@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 virtio-fs@redhat.com,  Hanna Reitz <hreitz@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Raphael Norwitz <raphael.norwitz@nutanix.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  Eric Blake <eblake@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 1/6] virtio: split into vhost-user-base and
 vhost-user-device
In-Reply-To: <20231107023330-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Tue, 7 Nov 2023 02:34:41 -0500 (27 minutes, 35
 seconds ago)")
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
 <20231106191515.2801863-2-alex.bennee@linaro.org>
 <20231107023330-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 08:03:16 +0000
Message-ID: <87jzqu6ldn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Nov 06, 2023 at 07:15:10PM +0000, Alex Benn=C3=A9e wrote:
>> Lets keep a cleaner split between the base class and the derived
>> vhost-user-device which we can use for generic vhost-user stubs. This
>> includes an update to introduce the vq_size property so the number of
>> entries in a virtq can be defined.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231009095937.195728-2-alex.bennee@linaro.org>
>
> Please do not put Message-Id tags in patches you post.
> These are used to map patches to email - this patch was
> In-Reply-To: <20231106191515.2801863-2-alex.bennee@linaro.org>

It was the last time it was posted. I just strip off the old ones when I
apply to my tree before preparing a pull request.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

