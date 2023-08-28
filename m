Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D378B90F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:06:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiTn-0004bI-Ga; Mon, 28 Aug 2023 16:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qaiTm-0004aI-2r
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:04:54 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qaiTk-0006aI-0v
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:04:53 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57354433a7dso1474595eaf.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253090; x=1693857890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KibOnnjBgf1KWSWpZZ3hV/YCPD6tUlQEaz82/LoHEcY=;
 b=fxYWbN+cpu09O5tJicKr703Kc65cZF3xo1g0wIaPk3KRLezzNWayolLo3bXXgbovmW
 MOCqDcx3PMm85VKvN4NBRoLpr2abi0uW05hkPNv1JEFKuB2QgEF42Wc/fKnZBYEP6frv
 4hMHH15vqhvvW/pJCSFxkXl/xwt0gT6XAHDERuFFWQ9fgNAmwlvHOHrztJBrRFXPDnlh
 VUlp1DPX1ulcr3+Zer+Dk3kp61YWOZo3BeEUI5MKeUY0iq9wFFiEGqr/UjpF43+JuJbv
 2JDmD3X9tuVP7uWtWl+7CAPVZviwqle+whIXr/wxdgofVvN/M51m92OsSFa0S739EFX2
 dIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253090; x=1693857890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KibOnnjBgf1KWSWpZZ3hV/YCPD6tUlQEaz82/LoHEcY=;
 b=QWM0IH9zIQtPZBt3l2H30e8Aj2kgvkQgIj35oh4fHNQ6DfJUONIRN5olWAjIOfGNb0
 tMk5XmJ9/ir6EwCkgHy3au78LY/Hi8NSWTeSJwh23xAxUXezVDMwdxvMXAyXzLOdzUXq
 xGq3gb/y7B3NVFzxvDMksZvvPASVAWw8FXcUP0L3er8UwBKDs8mijq/CaEZIzo/ZbKKU
 rFND8YTMMvMD9WFTdQnumik294N9JdK856la9dYbFBXpcuJ0aCX1Wl0C7BVwAY2bKg0E
 F1Yg3cyYAXk/iG25cfVC9jxFlLjxzgAjdlBVeO3yYrJSMp2zxgY+5yx7Vx+f3DgpOjWx
 OHAA==
X-Gm-Message-State: AOJu0YyyC18EQBdxOhgYAacLTz7ImuBAnb6ac06rxcZjBMD1hjVXr9+c
 9eYYhAkgTRO+3pYPbq68g/ZGDgHzdybds27rcOk=
X-Google-Smtp-Source: AGHT+IHwW+UGMlGkw1W5UfejkPFmIP9FR9aZyPN7xp6hZVFzUL7pLkC5eGRdJkUIY3ecLPuYIFzl6yeJrLpEEr6yHOc=
X-Received: by 2002:a4a:2a1c:0:b0:571:28d5:2c78 with SMTP id
 k28-20020a4a2a1c000000b0057128d52c78mr11141469oof.4.1693253090589; Mon, 28
 Aug 2023 13:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693228686.git.yong.huang@smartx.com>
 <CAJSP0QXLticPp0DOS=7bYQf0R0MiYpRXYu_dCRE9JVUbZd2nsw@mail.gmail.com>
In-Reply-To: <CAJSP0QXLticPp0DOS=7bYQf0R0MiYpRXYu_dCRE9JVUbZd2nsw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 28 Aug 2023 16:04:38 -0400
Message-ID: <CAJSP0QVtOgm8N5Z_qATRJLN9ibgbZKiRsbR9-QW+oOxUzh=zhg@mail.gmail.com>
Subject: Re: [PULL 0/3] Dirty page rate and dirty page limit 20230828 patches
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Andrei Gudkov <gudkov.andrei@huawei.com>, 
 "alloc . young" <alloc.young@outlook.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I see you sent a second pull request that includes the emails.

Please send a v3 with a signed tag. Thanks!

Stefan

