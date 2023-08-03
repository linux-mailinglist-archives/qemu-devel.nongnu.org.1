Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD576E6C2
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 13:25:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRWRl-0001LT-L4; Thu, 03 Aug 2023 07:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qRWRg-0001LC-BO
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:24:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qRWRd-0006r2-Sz
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:24:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe2bc27029so8703535e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 04:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691061879; x=1691666679;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3qmUGo8kNfHanLGIjLbhRLGy+X/g0Vhz3qltj0BZWb8=;
 b=QIhuuZxJsofTp47/foGtUdrZ+zxAurp8y34dpCrmLpDWQIc28/zAUZxT5bLppqgxRg
 2NANvnmGulzyfhwoxhIR52VoMUIQpEu1x5ffPW/emGdSBsvT5qd9SYd+6qqPNjz2+ACD
 2sYTxWTN5lqKj3vMYcJoJuxGB3XFqacjZ0cnBJmtoxfkE3JiGbPZaI1+BvfCw8mjkxHU
 FglU/2WLPjpquRoxYyTSrbSZ1vrjBvcKkQ4+wXP1373tUR/BZUEBXHUEctEh0itqRX50
 Uv4UabuVT9LLZBsWeFpeMA1tfwdQ6ut05Skz4ST8s0KMA3uFA2CWMi1GPz/lv2WOuUpY
 ExKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691061879; x=1691666679;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qmUGo8kNfHanLGIjLbhRLGy+X/g0Vhz3qltj0BZWb8=;
 b=l6lkslZbS3Mb5IVg+Kakjzrtferf+9Ruh91fAPmGU2rEThHX7ekWkaTa6HRr6H9uIX
 Du3ay/cvyHq//DG8+I01ZHNlbZ/rbB2KyVI1nsEJNs1JP9pMXuRD4R+E64nP0nIGDa+D
 u/JrA18WMmpue1bLfwQYfX3I55+Wa2Gdjepn34AYLEpXivcC2yJZoIl7NtIPypxuGLxT
 /+cCuitXm9feNgMXRgDb5XHsA1zOBqU3icwwP4QOGWhMRG+n1MV0XDZvOJpnFZOqg7La
 r6qfi6tJUOCzndiwAEYe8yKYGqqdIYF2vs3gh59ECfdSCY2/ygIZ3+GEdAyWCrJwjGOl
 0aSw==
X-Gm-Message-State: ABy/qLbNoGIFjbebbcvs5hB1/SKfogql5wtjwC3p+QxHux2QSKcSK/Fj
 L9d3rMDNNDkuFRp3WfI5HNU=
X-Google-Smtp-Source: APBJJlHq4BiJnfc3DrVLIiuMgp/qT1N1AOqKHUnkEwdLDi5MbURcNEcHgxmYRVmqXqCehJtbyn/5iw==
X-Received: by 2002:a7b:c048:0:b0:3fe:ad3:b066 with SMTP id
 u8-20020a7bc048000000b003fe0ad3b066mr7473614wmc.41.1691061879168; 
 Thu, 03 Aug 2023 04:24:39 -0700 (PDT)
Received: from gmail.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 19-20020a05600c029300b003fe2de3f94fsm4063758wmk.12.2023.08.03.04.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 04:24:38 -0700 (PDT)
From: Juan Quintela <juan.quintela@gmail.com>
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: "afaerber@suse.de" <afaerber@suse.de>,  Alessandro Di Federico
 <ale@rev.ng>,  "anjo@rev.ng" <anjo@rev.ng>,  "bazulay@redhat.com"
 <bazulay@redhat.com>,  "bbauman@redhat.com" <bbauman@redhat.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,  "cw@f00f.org" <cw@f00f.org>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "dustin.kirkland@canonical.com" <dustin.kirkland@canonical.com>,
 "eblake@redhat.com" <eblake@redhat.com>,  "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>,  "elena.ufimtseva@oracle.com"
 <elena.ufimtseva@oracle.com>,  "eric.auger@redhat.com"
 <eric.auger@redhat.com>,  "f4bug@amsat.org" <f4bug@amsat.org>,  Felipe
 Franciosi <felipe.franciosi@nutanix.com>,  "iggy@theiggy.com"
 <iggy@kws1.com>,  Warner Losh <wlosh@bsdimp.com>,  "jan.kiszka@web.de"
 <jan.kiszka@web.de>,  "jgg@nvidia.com" <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>,
 "jjherne@linux.vnet.ibm.com" <jjherne@linux.vnet.ibm.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,  "mdean@redhat.com"
 <mdean@redhat.com>,  "mimu@linux.vnet.ibm.com" <mimu@linux.vnet.ibm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,  "stefanha@gmail.com"
 <stefanha@gmail.com>,  "wei.w.wang@intel.com" <wei.w.wang@intel.com>,
 "z.huo@139.com" <z.huo@139.com>,  "zwu.kernel@gmail.com"
 <zwu.kernel@gmail.com>
Subject: Re: QEMU developers fortnightly conference for 2023-08-08
In-Reply-To: <9A87E859-3D80-40CC-923C-1B47243BD4C8@qti.qualcomm.com> (Mark
 Burton's message of "Thu, 3 Aug 2023 08:40:11 +0000")
References: <calendar-54c63850-6227-4398-b890-4b732835f682@google.com>
 <9A87E859-3D80-40CC-923C-1B47243BD4C8@qti.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 03 Aug 2023 13:24:38 +0200
Message-ID: <87fs50nzbd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=juan.quintela@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: juan.quintela@gmail.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Mark Burton <mburton@qti.qualcomm.com> wrote:
> Are too many people away right now?

Hi

Some of us are still working O:-)

But I think that the easiest way to cancel it is if nobody puts an
agenda.

Later, Juan.

