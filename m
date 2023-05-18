Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E392707F14
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbi6-0001aY-JG; Thu, 18 May 2023 07:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbi5-0001aH-1Q
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbi3-00088u-Is
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684408935;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Gj4Y/zxvU7eiDmaL8Zkl3HbtxKHDUtn1C17zh7NPLvA=;
 b=hky2YxcvchyKvKw93tdsIKDUPo7iUn8RlwVbUojcv9rkw8xUvgDpEVND9+63FeSW2Tovw5
 R6ogtkCdU7cyaajpH5QGNOA7wtYknQ4A9VudL4N1uU+bfqe3A28ENgSLo4iCjj6o21keLr
 z0T8BL+EdOzO+IVwXet6PvB61FQnJqI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-369B9BvQN1-LOAUc31bvrQ-1; Thu, 18 May 2023 07:22:13 -0400
X-MC-Unique: 369B9BvQN1-LOAUc31bvrQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-306295777ecso551431f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684408932; x=1687000932;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gj4Y/zxvU7eiDmaL8Zkl3HbtxKHDUtn1C17zh7NPLvA=;
 b=dZzN30kr1/XjxfqM5nX0MSdR58qmhAcayRTpLAAYPpZol8uHb+yvw8dsQBhu+tTpMN
 LRZ21KVVxh0siVRGMPOS71iJ56PhFl1yLMTdZBaaZWvwQN54W7SEe9AfzFa2tpZKxzTJ
 4LpK+RmfhTAfX8x8Rj9lqeaR20FrLW6+kKGjCqjg/tYggRfsEt5xWcCPkoG8ZWtTUPdR
 qyXEVkkgfmt29oFYt+u326bZyFiCW/8tKzfRnPUcIGh7U+iwYAx6R0KikTAlYkuspsv2
 fsP9N2gNYwgne4CIUWSHjv8F97nJ7bhjECsJ8R5MLxHXMgBBcj99iPdTv7ASzgF8xCKm
 6Fkw==
X-Gm-Message-State: AC+VfDywzYRAUJLxn9HW35gZ8QebuB9fkc3MopUEATEApkOAxKZ8hQQ0
 x0uv29s2e1ybhVgxrVRhtSH+WDb/b+Hz0Zp+4g3zPTTWGdoWdo4WAMc5NswDdrQ9ebLplCYy1T7
 mKHwGbfsCgTIw/I0=
X-Received: by 2002:a5d:510e:0:b0:309:3574:5930 with SMTP id
 s14-20020a5d510e000000b0030935745930mr1248892wrt.8.1684408932620; 
 Thu, 18 May 2023 04:22:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OoS2BcoEtb/NZkJyXWZsFYjfUDDizHnJoEcH7yXu2nF46NhqomT9vkJcjcLVgGSKHb6dlnQ==
X-Received: by 2002:a5d:510e:0:b0:309:3574:5930 with SMTP id
 s14-20020a5d510e000000b0030935745930mr1248872wrt.8.1684408932234; 
 Thu, 18 May 2023 04:22:12 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f23-20020a7bc8d7000000b003f4290720d0sm5052240wml.47.2023.05.18.04.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:22:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  leobras@redhat.com,
 peterx@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH 5/5] migration: restore vmstate on migration failure
In-Reply-To: <20230517123752.21615-6-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 17 May 2023 15:37:52 +0300")
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <20230517123752.21615-6-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:22:11 +0200
Message-ID: <875y8pevfg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> 1. Otherwise failed migration just drops guest-panicked state, which is
>    not good for management software.
>
> 2. We do keep different paused states like guest-panicked during
>    migration with help of global_state state.
>
> 3. We do restore running state on source when migration is cancelled or
>    failed.
>
> 4. "postmigrate" state is documented as "guest is paused following a
>    successful 'migrate'", so originally it's only for successful path
>    and we never documented current behavior.
>
> Let's restore paused states like guest-panicked in case of cancel or
> fail too. Allow same transitions like for inmigrate state.
>
> This commit changes the behavior that was introduced by commit
> 42da5550d6 "migration: set state to post-migrate on failure" and
> provides a bit different fix on related
>   https://bugzilla.redhat.com/show_bug.cgi?id=1355683
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Juan Quintela <quintela@redhat.com>


