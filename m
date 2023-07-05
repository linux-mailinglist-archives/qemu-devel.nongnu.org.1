Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63C7487A4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Ez-000821-1E; Wed, 05 Jul 2023 11:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH4Ev-0007yo-Ri
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH4Eu-000243-CM
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688570179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmk6zBV5gyK4lAO3oTqBHfWgQV3L91TobL8FQgAnknY=;
 b=cK5xm7zMt8s8UvIMfm+WalLxo8xmBcU5d4L2ang+My/8oxeBlwfOmZpQ40tDZ+VRDgm4T4
 RTASIs+avHJnF88hk2By95txonmw3MkSg04Dlqc+Rdvbdg8Dqe0Pr4UerRnVoiJI4TLjjv
 lu5B1z2cX7ors0PeGMr9LvG9ha5lIsY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-2yyRd7nmP06zxe40dYGYwQ-1; Wed, 05 Jul 2023 11:16:18 -0400
X-MC-Unique: 2yyRd7nmP06zxe40dYGYwQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7673887b2cfso187652885a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688570177; x=1691162177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmk6zBV5gyK4lAO3oTqBHfWgQV3L91TobL8FQgAnknY=;
 b=NFLCXS5EDeD3cegViMjYGfN/cvibmHJO81M7mcLb0asi17JIL+nHk8P7OwHcqF65qv
 U+RT9jsmNopKThCYgHifQYfIfG65250X4LGRx3EoeouGF2C04VT0+58ZGnD+Tt5m7idB
 vWabYOvPa6TAloz0tirnqMIH315DoO+yejQh6XGWXF/nM1aM25bYPRFZ0DpbITer3Kms
 D3Cr1LyETAbWqjXw5xKpRPAdFwrwe26XsFPkKyx0hkmdp3Q9EBxCmesRgc4NpTI1pLmt
 j7oH9fx7cPOh0E4mCSw0nszngVhXv2x8ai6//LnvSAU2QetPCUHlUKRhhCHGUneK1Jxd
 WnZg==
X-Gm-Message-State: AC+VfDy/xpWXr2eMrFfou3NiUwb2XWNq/hHC8Ve70b9kRJuCLuD610cE
 8dUZVWRdUuHLMpJMYUIOKbl/bCXA6uimOXOMD7G/4GXV110/8X+jQhYk8G/xR5tSumbt5EwA3Qx
 7LSH6bVkx7m2mKR/Y4A6vdQX43pHNI2wIjV4y+plFOMKbEdpbfz+cN0/u4zeJ3/lcKLXa4Xv0
X-Received: by 2002:a05:620a:4626:b0:765:5b3d:8195 with SMTP id
 br38-20020a05620a462600b007655b3d8195mr20200575qkb.6.1688570177470; 
 Wed, 05 Jul 2023 08:16:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48Su0z526IIpPbEIm4kycADknZVqmLOUzwqvEHwMfNQSS48HRgmfCX1in9cqyNjnkWy+4MmA==
X-Received: by 2002:a05:620a:4626:b0:765:5b3d:8195 with SMTP id
 br38-20020a05620a462600b007655b3d8195mr20200552qkb.6.1688570177097; 
 Wed, 05 Jul 2023 08:16:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c20-20020a05620a135400b00767171e4eeasm8787464qkl.2.2023.07.05.08.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 08:16:16 -0700 (PDT)
Date: Wed, 5 Jul 2023 11:16:15 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH v3 0/2] migration: switchover-hold flag
Message-ID: <ZKWJPw8MCCQNLLDk@x1n>
References: <20230705150825.305076-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230705150825.305076-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jul 05, 2023 at 11:08:22AM -0400, Peter Xu wrote:
> This v3 patchset is based on master.  Since I'm not sure how long this
> series will take for review, we could probably apply Dan's previous patch
> 10 first, then when I repost I can provide a revert patch when needed.
> 
> v3:
> - Rebase only (v2 is not yet applicable after switchover-ack series merged)

I got an unused var in this set, I'll repost again shortly, sorry.

-- 
Peter Xu


