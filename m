Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 269507DCBFB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:39:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxn5n-0001Wt-Jd; Tue, 31 Oct 2023 07:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxn5l-0001VI-Bw
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxn5d-0004np-Ox
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698752360;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CFJRcF7Wbg5eD+9ZiiSOtEJdASvS/ktWKOUBj7sQhNk=;
 b=Gj54mNvbK0dfATMdpNj9HMl5ZIzw3749SwPcjIhFusfIuMCVFfZXsWKaP8+egDzOeDa82b
 Gs3SS7JXWdKi9uF19S2Qmv2h7WMQFRNIy3LYtOEJ/zimaJD/gyDKXjgvEyU68aQg/PrhXE
 cqHazh7/cqznEgWOam1hLJS90siMMls=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-AFCru1Q2MXKOIjWBvvROCw-1; Tue, 31 Oct 2023 07:39:19 -0400
X-MC-Unique: AFCru1Q2MXKOIjWBvvROCw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5090f6a04e1so3386722e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698752358; x=1699357158;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFJRcF7Wbg5eD+9ZiiSOtEJdASvS/ktWKOUBj7sQhNk=;
 b=mxnNXBNvyrXbl2sVoBSsSP6zu7zKrlvJt4vL9gUTzhPnlrIOypfklKKrGmg5RTlcjO
 9sFGggjjgoyUXpzFcVfB0KqgMIUrdddLYPlNVvdB0m1CRJcIyaAL/Dks/dX2GL/cOgbU
 RZBt1zPu8nHDeubC5/QDKxPpY2sQNk68orFDidNA6BVhT4E9HRElhqZvdBIfC6P6sNIF
 BReID66Q2LMPv/TV02P+srz6f5IWz+27GEznxAfcH7Q8RIOdMTxKhB2mtv8pBhpLzrjU
 7SpcDfu+uyLn5aBpuuYYYjnunpdSNO1ewhgaHON9CKqbHg8EJlkO4c1aLFK8Hqh7FhMO
 yyUQ==
X-Gm-Message-State: AOJu0YxVWa0rwcfWayHdjBLuDuIDmHerQs3Jt/IDK6dMae2M/3rwMSHn
 1ykX/TKwL9McXdwwYH865W5eK0wXbwnmx6FMtAwDnnkHDC8e39sjFx8Ab9fJ5TyxDXkJ5Exalia
 N8bVyjqppAgv0HIM=
X-Received: by 2002:ac2:4463:0:b0:503:9eb:47f0 with SMTP id
 y3-20020ac24463000000b0050309eb47f0mr8695202lfl.59.1698752357902; 
 Tue, 31 Oct 2023 04:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZHVuOxgOsq5DEXJj+mSoliCs5HaBu7cCyDZ89fUgVVwfbLwEqFf1SJJGmhngIExcc/MINZg==
X-Received: by 2002:ac2:4463:0:b0:503:9eb:47f0 with SMTP id
 y3-20020ac24463000000b0050309eb47f0mr8695191lfl.59.1698752357591; 
 Tue, 31 Oct 2023 04:39:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o8-20020adfe808000000b0031980294e9fsm1308185wrm.116.2023.10.31.04.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 04:39:17 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Joao Martins
 <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 2/5] migration: Add migration_downtime_start|end()
 helpers
In-Reply-To: <20231030163346.765724-3-peterx@redhat.com> (Peter Xu's message
 of "Mon, 30 Oct 2023 12:33:43 -0400")
References: <20231030163346.765724-1-peterx@redhat.com>
 <20231030163346.765724-3-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 12:39:16 +0100
Message-ID: <87r0lb81i3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> Unify the three users on recording downtimes with the same pair of helpers.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


