Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6917B830D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3Kc-00062t-Jh; Wed, 04 Oct 2023 10:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3Ka-0005zW-Oo
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3KY-0005KH-O7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696431510;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ANPZJ+/gOlTGUbpQQjiiG93h99vtDdCv2jvU204H888=;
 b=Fu3CXuQ2AI4irESO/3qn2FpAx0gllaI8vCkOP7pvWzyQKCQSmw37vLFAK0FzWfLaCifX26
 uXHbhy/X18MF9hJv8hI9g05wbcOCSoFU2GUflHrq0ERQhNs38GCFhDF2WLauOmmFEd2CR8
 mUXv/XiYMbXhYP6TeS6UmYHgiSQ8bYo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-Hdbe4b0vOmyN4khFifnLPw-1; Wed, 04 Oct 2023 10:58:28 -0400
X-MC-Unique: Hdbe4b0vOmyN4khFifnLPw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-327b5f2235aso1739226f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431507; x=1697036307;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANPZJ+/gOlTGUbpQQjiiG93h99vtDdCv2jvU204H888=;
 b=eEMB2dXaXqdqpE7dNUFgsPMf+vfMqSeXC9uz39gm9RGi1cKbx4iCSHZs3rHyByOK6g
 FSlRhG6XxoHNohYsFHOhxjlIAD27WGeZkV3bW/uppM3yHWYPNXQcnz51I1A6WUAP7+EC
 HvnBu/sq+B5OTvQUd3UR6IWekw+CVFpCySmrXGLWPcFRNLkaS4bR9/pKWAjGguW2aTIx
 QXh9n9qg7OK7WtVfEalOIkGTb7fyKKhvFwY8HJZ/QuD9nMFXQCoVn1R/fcvAGItO6kiq
 HGKFsQjC3QFLL0m2AF751COEIar7s/7JLT4mjlJOk7JVvLhHHPi2FQVK06ftDfoBllQF
 urvQ==
X-Gm-Message-State: AOJu0YxbtKbOhE46ZwnuZ8+fQ6mntPwXkn7ukqW0pOhVIrbEwwnYD5vX
 AjUnLAgSIiex2c1e0GZSuUaT8HRyQWqIc7FTkel8sEFWf8gqb/k0R2/7CX+SbKfqp0HXjMj5y8D
 l/gfqZFIL9+J9wmI=
X-Received: by 2002:adf:e541:0:b0:317:69d2:35be with SMTP id
 z1-20020adfe541000000b0031769d235bemr2372607wrm.30.1696431507216; 
 Wed, 04 Oct 2023 07:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1pL5nn3J9BeslsQeE4a8Rg827wqAOo8opMAnRC9H6wHtnTYWPVCYgFIubxVrO0W/RjcYBlw==
X-Received: by 2002:adf:e541:0:b0:317:69d2:35be with SMTP id
 z1-20020adfe541000000b0031769d235bemr2372588wrm.30.1696431506898; 
 Wed, 04 Oct 2023 07:58:26 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m20-20020a7bca54000000b00406408dc788sm1732761wml.44.2023.10.04.07.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:58:26 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 12/53] migration/rdma: Drop rdma_add_block() error
 handling
In-Reply-To: <20230928132019.2544702-13-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:38 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-13-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:58:25 +0200
Message-ID: <87ttr6xwmm.fsf@secure.mitica>
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
> rdma_add_block() can't fail.  Return void, and drop the unreachable
> error handling.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


