Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B297B8382
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:26:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3ki-0004KB-Dc; Wed, 04 Oct 2023 11:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3kZ-0004CN-Id
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3kU-0007Me-2e
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696433116;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JQvv6lkzBGqLdGun07GO8pip0kDZqu05gTcF9xUJvWc=;
 b=E2ffeTd3cQorEd5smbCq2znuZ/Gq1wP5FBx0cUTDQ4ceixwKV4eujFqR97FykfGbwix0px
 AnyYVTWgLAMXqfSy737j+Lr1SIHPq3R0hCP+DZQvj/qykclZdMohsap9LICsdV/n679xMo
 TpMuUg0Ca5eP0nFzFeQ7hBZfF5obASI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-mGS71_JVN0urYDnYY5JHhA-1; Wed, 04 Oct 2023 11:25:15 -0400
X-MC-Unique: mGS71_JVN0urYDnYY5JHhA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4067f186039so14626225e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696433113; x=1697037913;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQvv6lkzBGqLdGun07GO8pip0kDZqu05gTcF9xUJvWc=;
 b=nMtQqYbclpdpydOdTZvAPBtlKOcDaZRSloTEZztdss/KpVf4Py8/Z/qG8ulwYstSrF
 P9jEJw8kR3ujD4zmtP7TcIobxNhNQXq22rLgUbmAAq3OI/XTKAS1vayjYNHbVSKPCJnz
 pjVTI140w6wPnsx84qn0BV5Lpi2s79Q/DdC1KSECF4DTayDX0vfOJuAQrxEIaoJxDdm3
 RoeDRThU46Gr99ZcY2vNMYxNQRTDyVZFNishEvscplMoNV7x+Recyvm0CQHjXkWzipHn
 Nsmi7/zTGPGi8P4l+dwwXR91ncgBsne0uTrWzwXx+w2EKzHlGzq+xS1qDujcmpriYxgq
 z7/Q==
X-Gm-Message-State: AOJu0YyuciryLDEArFamSMnObgqdovD2Uzn6KSa6MUkppFeXckF8KRkk
 oZQn+t0nFAyP1ejWaZWofC241+x5dj0AM5mMnykE/9pCl5sc4qWTKds/f/tva6u7ppQhcqBWCTo
 j07rKca8rxhULtqh891jwjjjRvg==
X-Received: by 2002:a05:600c:3799:b0:402:e68f:888e with SMTP id
 o25-20020a05600c379900b00402e68f888emr2800062wmr.4.1696433113190; 
 Wed, 04 Oct 2023 08:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXIK99S1YYirNlSk0WzGSTaTWS/xUnSh2tTi/IOnVHrQthGbQSoyEMHaS31yjxzSUX48er0g==
X-Received: by 2002:a05:600c:3799:b0:402:e68f:888e with SMTP id
 o25-20020a05600c379900b00402e68f888emr2800045wmr.4.1696433112882; 
 Wed, 04 Oct 2023 08:25:12 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c00d600b00405ee9dc69esm1788168wmm.18.2023.10.04.08.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:25:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 21/53] migration/rdma: Fix
 qemu_get_cm_event_timeout() to always set error
In-Reply-To: <20230928132019.2544702-22-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:47 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-22-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:25:11 +0200
Message-ID: <87v8bmwgtk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> qemu_get_cm_event_timeout() neglects to set an error when it fails
> because rdma_get_cm_event() fails.  Harmless, as its caller
> qemu_rdma_connect() substitutes a generic error then.  Fix it anyway.
>
> qemu_rdma_connect() also sets the generic error when its own call of
> rdma_get_cm_event() fails.  Make the error handling more obvious: set
> a specific error right after rdma_get_cm_event() fails.  Delete the
> generic error.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


