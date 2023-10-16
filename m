Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E0C7CA0E2
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsID8-0001Uj-Tz; Mon, 16 Oct 2023 03:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsID6-0001Qm-FS
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsID4-0007Zv-W5
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697442018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZHUyVhFeWmXmrDZEIh+m7jfrriEnukYRyJ7RJJWHIeQ=;
 b=gG8LnFXtLIvtCY3UvwcDrtEXpM9S+6ZJujbMfiIecks4DuW2Q3NSXqbaK75DUD+vnKuagN
 FXzHg8StCE/J18voFAhs9pxqtQSXwfsqxpoQCGWHvFwbHtili8qFHwXLTW80vlJQWXY1fH
 qbVT42xxkAu+lLtSsyn2D/nbDweqa3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-FhP7XU4-P3-tkgQ-v5Vb-A-1; Mon, 16 Oct 2023 03:40:16 -0400
X-MC-Unique: FhP7XU4-P3-tkgQ-v5Vb-A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso2581607f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697442015; x=1698046815;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHUyVhFeWmXmrDZEIh+m7jfrriEnukYRyJ7RJJWHIeQ=;
 b=hMyalSRfoNqyoM6cj67DtMPAO4/TFeXNBpzHLKUxtyUYOiLQgQzilnVQXycVUCSvi4
 9g+sm8ABWU2NMp+yYsAWue7pF4bhfX4B6M5fFx+k8UUI7tASiWi7qjRwcgmvwWeloypk
 bvPkCdzGdIfqwVjXdutAV9K2rD7MMq99kHLsQ7UvLJ98xRZTmJySzV1CyMOKBmDVdjCA
 xRftxsuk3NMkiv5M7kl/ZCirzudw1iT4ftIF3F9EOK8ABuUZiZC8Jfgpc4vqxcJypvh7
 8pfJfl5qJZRMZKfq5mw0AF1VEQiuE1tMjGfmXFU2r+cXxTVtfww81upTh7S2EaWZDqTP
 PvQA==
X-Gm-Message-State: AOJu0YxYKqm5ujFtz+8bncf3XX6q6yHVRIIxI80c0Yj8AyEHpVoMApRB
 Tli2mJIwdKcQMP9zpvzGSbjqQjd+vuytORgD7N2BKK6DhVGVEa6nFgHcKCQgi/JTG/NSa3di7wI
 +2M648N9a6PLJmrE=
X-Received: by 2002:a5d:60c9:0:b0:320:8e6:b0cf with SMTP id
 x9-20020a5d60c9000000b0032008e6b0cfmr26311727wrt.42.1697442015509; 
 Mon, 16 Oct 2023 00:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+lgetal3KYkqLbkgizXuf5rKzcw3tTRSXqbQXLlf/OpsHby3di1Gkf18mP++FYatfyIyQlQ==
X-Received: by 2002:a5d:60c9:0:b0:320:8e6:b0cf with SMTP id
 x9-20020a5d60c9000000b0032008e6b0cfmr26311717wrt.42.1697442015323; 
 Mon, 16 Oct 2023 00:40:15 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e28-20020adfa45c000000b0032d892e70b4sm12393680wra.37.2023.10.16.00.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:40:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH RESEND 4/7] migration/ram: Stop passing QEMUFile around
 in save_zero_page
In-Reply-To: <20231011184604.32364-5-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 11 Oct 2023 15:46:01 -0300")
References: <20231011184604.32364-1-farosas@suse.de>
 <20231011184604.32364-5-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 09:40:13 +0200
Message-ID: <87jzrn3tia.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> wrote:
> We don't need the QEMUFile when we're already passing the
> PageSearchStatus.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


