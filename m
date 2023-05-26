Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C484F71222F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:28:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SoI-0005Ew-B3; Fri, 26 May 2023 04:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SoG-0005EY-Dt
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SoE-0000WN-UZ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685089706;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZUx0l85WkeAFALN8rKwG/i6ZAb1+WrzNxGK8CA4tNcs=;
 b=Lx6i9HwFMw8KHHwV7trTn+EsFALdYj0HkKffzeG7x06mW66/EnPLWfFowpNFbYJaCr4peQ
 +FB9jy//ZCSfnU87RL+KkneReL92BZyOohzL0yhhLpxPxx6F7Q+cctVmYY6tZHaAgeRoPE
 hBsTZI/KilpyOFxlSio3HFtjmheKaV8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-PM3xz6u2Mbu5qohZ0s_oag-1; Fri, 26 May 2023 04:28:24 -0400
X-MC-Unique: PM3xz6u2Mbu5qohZ0s_oag-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f50aa22cd2so3534085e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685089703; x=1687681703;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUx0l85WkeAFALN8rKwG/i6ZAb1+WrzNxGK8CA4tNcs=;
 b=eph24hJpbPq2+Vg/4OJIft+QKPxBKxRk0ELkNdOfbi8eAJVmlRVK4perlxnflwaprq
 n5r57qPsn6mleUHbLRAujPPK4tDb9hV0BglHNZc4xT9rcFTHjmDqves3ywQLcmxXiaZk
 cjh3z0bFsU9fCtHp6cTkctJIfCbToUsrgRRoFACnPNxeKFMoNQHADa0XVS+p97WLgOSP
 TZaT1v9VaYR6VOH7Y3GwBeVWh/3aBDp/ArPMnR0siSJOqKDgbdzRZKdkyHACqriAPV87
 zClhFKEmshg223fMQo1boSU6lxJ/tJdNoYQR3SUfIwTn9VvlzQrFS0c4NjuWlj0k4B5h
 t0iQ==
X-Gm-Message-State: AC+VfDwvUZfr6/lyrs+L7r9PQaldXcClgtmXrBAEIlDpiS99LMO3G2c9
 5gP17Jw76uMIdg12aHhc1KI5kANOikfv+Azv0PTj/91et1R5DTq0BrNFvXlD5Q8eku1dagCr8ll
 EPkORQNTUt6xaIrA=
X-Received: by 2002:a7b:ca4d:0:b0:3f6:d2:d8c0 with SMTP id
 m13-20020a7bca4d000000b003f600d2d8c0mr979702wml.19.1685089703703; 
 Fri, 26 May 2023 01:28:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4z/yMK98XmaIN7s2RzKkctU/dZz2KormB/ZAS4b77V01fPxKrJV3CEYjJE5OwMT8HD6+mIrg==
X-Received: by 2002:a7b:ca4d:0:b0:3f6:d2:d8c0 with SMTP id
 m13-20020a7bca4d000000b003f600d2d8c0mr979687wml.19.1685089703395; 
 Fri, 26 May 2023 01:28:23 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m19-20020a7bcb93000000b003f605566610sm8100908wmi.13.2023.05.26.01.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:28:22 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  leobras@redhat.com,
 peterx@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH 2/5] migration: never fail in global_state_store()
In-Reply-To: <20230517123752.21615-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 17 May 2023 15:37:49 +0300")
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <20230517123752.21615-3-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:28:22 +0200
Message-ID: <87fs7j33a1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> Actually global_state_store() can never fail. Let's get rid of extra
> error paths.
>
> To make things clear, use new runstate_get() and use same approach for
> global_state_store() and global_state_store_running().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Juan Quintela <quintela@redhat.com>


