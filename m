Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2808241D6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 13:35:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLMvw-0008Rm-EA; Thu, 04 Jan 2024 07:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLMvv-0008RX-7H
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:34:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLMvt-0005t5-Nw
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:34:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e35b574d3so895215e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704371684; x=1704976484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wms3dpvnBhgVjNuZl3PUsy8mrAq7XiIWLGpTtqiFqIU=;
 b=ImQRSFka+f94eyKT/H0TMa2eRf23SxrUB1wY2xhYK6nCC1OF6LGalSekj50OthTzjj
 bgyedyEC5CSRUv9T427V9gOm+bPpcvyrelkGgIdST3+iR4p1cBjnf5VjDRR0QUPEiK0R
 3bq6e1uNnjxp2rBk6/TzJ2fF2eir8f8T80K6h7OngRMA+lwHt15HavR8mhtkFYkmCRK9
 a0SBXls1YJdh2Op+vmwVYjChiwi0dqu62rLW4LNYbvolC5+zrUEVUy8gFE4nfDpGIPSy
 yWYK/gSHAf7I75G7uaqWXszpZynKpgp7+TVv/1v/hdYbD1QYXmoBsz9RfY3/GoYpxNQc
 2ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704371684; x=1704976484;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wms3dpvnBhgVjNuZl3PUsy8mrAq7XiIWLGpTtqiFqIU=;
 b=vml1JJjB9HoPQAuV+5xiupmC7Fuknq0/RRNG+gEhpABkf5QWEV6WIzzCvEKG/ZK7CF
 5CNuxFU0YhhqXq1OCHPf+dvcRCrDHbwnLdya3TmeN1wLYMu5gq29KbTK0NJ2Z1yDpX5T
 IADbTHbyVAuv3MkwX/owHztlUuzlZxHfffBckIYRbKuLPC1tYwYh1H7QpF9AXLwe062f
 AvGnYSrCb4ybniyYqyifA71XgQvFUCqDpeVp/zxlOmtpviq0dPmlnmgzEcqW7U1xufHS
 5CRl9ST1We35xZCNonWJDVst5bcDVgLxMNOkz+DsicTEWpV0XZMN6HSU/Dr3pdnfiuiE
 FU5g==
X-Gm-Message-State: AOJu0YxpSdsXihmzDF90mnuQD0zohoJ9a2GLg211l8JMpYYUVXpWy5Bu
 v3Ysw47YNFxiBhF+DDi4FyT7010iVzFkKg==
X-Google-Smtp-Source: AGHT+IF+F76/tteQLY08vYDTyb5g9TCS/Z41jEtFnzKJL+rA1jVnPIB4w5fhBW5nnT6F/rS2J+Uwmw==
X-Received: by 2002:a7b:c3d9:0:b0:40d:9006:51c5 with SMTP id
 t25-20020a7bc3d9000000b0040d900651c5mr322686wmj.143.1704371683968; 
 Thu, 04 Jan 2024 04:34:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 hn33-20020a05600ca3a100b0040d5ae2905asm5467315wmb.30.2024.01.04.04.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 04:34:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 377B95F92F;
 Thu,  4 Jan 2024 12:34:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 0/4] virtio: Refactor vhost input stub
In-Reply-To: <20231120043721.50555-1-leo.yan@linaro.org> (Leo Yan's message of
 "Mon, 20 Nov 2023 12:37:17 +0800")
References: <20231120043721.50555-1-leo.yan@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 04 Jan 2024 12:34:43 +0000
Message-ID: <877ckpgtuk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Leo Yan <leo.yan@linaro.org> writes:

> This series is to refactor vhost stub vhost-user-input.
>
> Since vhost input stub requires set_config() callback for communication
> event configurations between the backend and the guest, patch 01 is a
> preparison for support set_config() callback in vhost-user-base.

Queued to virtio/vhost-user-device, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

