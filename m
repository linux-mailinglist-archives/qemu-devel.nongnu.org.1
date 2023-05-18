Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE7707F0E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbgZ-0000iw-Ka; Thu, 18 May 2023 07:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbgX-0000gs-97
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbgV-00081a-US
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684408839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5ahp6IZYagH1ikl22Y51trhZMvAYZqyEikQotXsxazk=;
 b=RfsPwzJvTEpDt1YeA9M4gM6WdA2CA5xlIf4hJsfxmEoYi1pzqFsBE0gVPVMx4upMe2OHYv
 29Km2u/PCpIny6ZDFhmeBy9z5uC4sFOve5KxpkNUm0rtzIOsvAdznAtbnhuKlJAnQIujvY
 tm5pTwlgYPD5BGrXaoHViq+l5zyD3zc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-yUmOJYygM1ejIojpfgC2IQ-1; Thu, 18 May 2023 07:20:37 -0400
X-MC-Unique: yUmOJYygM1ejIojpfgC2IQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42b226871so8000325e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684408836; x=1687000836;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ahp6IZYagH1ikl22Y51trhZMvAYZqyEikQotXsxazk=;
 b=Q4rH6bx1V+SKeqX2spAhPfOOZ1ITs3Ape/T0aIEakj4qiMkDN7fMjlx81SlahW02sO
 9f2Jlk/tZ0DdA86BFSGTtwDrbuqLHg5rVPd5kFwfo0+cAc29pBtuF6xNJM5zX0jsQTYV
 gw/PIXHpBbPLBsZhPo4CwcUPyIk9p2cVuiw+iE7UFO8QfU8bGj309Rz4zh+qlVcQHYnY
 SemFfT5q5E4apEaS5XMyRkk1y/lgRbXPa6GDFf8rXEnuVamJGCILcmTW/9r83reVhaKa
 /8L4BZLimQnNZrhKQomihuKN17yviilMleeWJAgDm/xsJ9ro/dy/x4PoR8XQlitRgjlC
 TRag==
X-Gm-Message-State: AC+VfDxN9c5tXXc+AMVm+ykhTtJaYWFKTSJFgQaWcuF2a2Rb7DkFDloI
 HBkvs9xj6ZiqINwheO2UigVN9n2jAk4k7PNT85+6QIIofIXUjSIt2D9SEJu8TjnnjQ0VaxDmBXz
 74khzfCyyRS7nViI=
X-Received: by 2002:a5d:5233:0:b0:2dd:11b8:8aa9 with SMTP id
 i19-20020a5d5233000000b002dd11b88aa9mr1279190wra.15.1684408836639; 
 Thu, 18 May 2023 04:20:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58GcI9d8lAj1IW/PTSd6NVW+ptwoG+7PIAUR0DZ5LR7uQGVcZ40RjgtXE3T046eWGCxZ1/cA==
X-Received: by 2002:a5d:5233:0:b0:2dd:11b8:8aa9 with SMTP id
 i19-20020a5d5233000000b002dd11b88aa9mr1279180wra.15.1684408836368; 
 Thu, 18 May 2023 04:20:36 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m14-20020adffa0e000000b003062ad45243sm1902509wrr.14.2023.05.18.04.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:20:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  leobras@redhat.com,
 peterx@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH 4/5] migration: switch from .vm_was_running to
 .vm_old_state
In-Reply-To: <20230517123752.21615-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 17 May 2023 15:37:51 +0300")
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <20230517123752.21615-5-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:20:35 +0200
Message-ID: <87a5y1evi4.fsf@secure.mitica>
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
> No logic change here, only refactoring. That's a preparation for next
> commit where we finally restore the stopped vm state on migration
> failure or cancellation.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Juan Quintela <quintela@redhat.com>


