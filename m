Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6285D7B81B6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2UP-0003dV-6r; Wed, 04 Oct 2023 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2UM-0003bP-Ji
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2UL-0006mb-0H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696428272;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KcdxC79HL336v3e2in8zo6K9/7pGEaRpfSCQsFm6tBc=;
 b=jM0zR5nViVLQX8ZQFHwq/GFRhsxEBU+tq2kMS9ZPsdZ4ijLoICzcuceHBqT7Q6Jr8Msfua
 rfohgSaJqJQdyfjOV+YfkIvOR+mVNs2L26mB5UyeCoIRlQLLo6H6zgX/70RVfE4I+Ns63+
 OFEJCIT2NQUZXzj7CHq067pURV+f5D8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-ahwaUv6vN0a1gOR3eNjwlg-1; Wed, 04 Oct 2023 10:04:25 -0400
X-MC-Unique: ahwaUv6vN0a1gOR3eNjwlg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so14883875e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696428264; x=1697033064;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcdxC79HL336v3e2in8zo6K9/7pGEaRpfSCQsFm6tBc=;
 b=ATDFe2LMAw1bw/X8Z3/xiR24RvhE0cRQTqVWJbfsFYYwR2YgOd37fi9MisBXgmSrLs
 JqnmhycXpVTwhWppR+TiREoX2Poq7HstO4irWSQEe5Som4+HJsddKqLm6A/u6xO5LL+1
 TYsH8yiIdeGSKGu+5k1R8cByTtb3W8MOwqs9W/QKmjisIKf82u63uG/5nmeDSi6XCvyi
 l2DmdUmgG8Z9FSmTNbzKcywiuaDn37kNi5rTh1CPUvqFrDjBRqnSQfKVxjjZrEyL5j+X
 WNjJ+8bt6HmrBQD8vvMIQST+peddVK6POx0GqWSyFLytHkAQb586CVXhrTH1T1ZSWeLD
 ebmQ==
X-Gm-Message-State: AOJu0YxlACZSpzAL7D/eR9tOQqb8gwIOR1LNZkJAsGMwD82y8M9dHMnF
 8V7DcizrKUYm3xtmoYA2NPr1N8uL2MezMi3wRyr5vhHgvDl5Nd4LVjLN0GITrUa+DuXZuGoVDwr
 WNQMPapBTjzhZcxc=
X-Received: by 2002:a7b:c454:0:b0:403:b6bc:dc83 with SMTP id
 l20-20020a7bc454000000b00403b6bcdc83mr2248902wmi.38.1696428263876; 
 Wed, 04 Oct 2023 07:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9ZCgFxqVRQU0CFKuuiBM1fvMXMfa74Ce7KKDasdwc5bj+OFhC3iCycaKmbrU9Oys9JhJxlQ==
X-Received: by 2002:a7b:c454:0:b0:403:b6bc:dc83 with SMTP id
 l20-20020a7bc454000000b00403b6bcdc83mr2248851wmi.38.1696428262908; 
 Wed, 04 Oct 2023 07:04:22 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 b7-20020a5d5507000000b003247f732c11sm4111949wrv.76.2023.10.04.07.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:04:22 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  qemu-devel@nongnu.org,  Markus Armbruster
 <armbru@redhat.com>,  Zhijian Li <lizhijian@fujitsu.com>,  Peter Xu
 <peterx@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 libvir-list@redhat.com,  Eric Auger <eric.auger@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] hw/rdma: Deprecate the pvrdma device and the rdma
 subsystem
In-Reply-To: <20230927133019.228495-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 27 Sep 2023 15:30:19 +0200")
References: <20230927133019.228495-1-thuth@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:04:21 +0200
Message-ID: <87zg0y1o2i.fsf@secure.mitica>
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

Thomas Huth <thuth@redhat.com> wrote:
> This subsystem is said to be in a bad shape (see e.g. [1], [2]
> and [3]), and nobody seems to feel responsible to pick up patches
> for this and send them via a pull request. For example there is
> a patch for a CVE-worthy bug posted more than half a year ago [4]
> which has never been merged.
>
> Quoting Markus: "Given the shape it is in, I wouldn't let friends
> use it in production" - we shouldn't expose this to our users in
> the current state. Thus let's mark it as deprecated and finally
> remove it unless somebody steps up and improves the code quality
> and adds proper regression tests.
>
> [1] https://lore.kernel.org/qemu-devel/20230918144206.560120-1-armbru@redhat.com/
> [2] https://lore.kernel.org/qemu-devel/ZQnojJOqoFu73995@redhat.com/
> [3] https://lore.kernel.org/qemu-devel/1054981c-e8ae-c676-3b04-eeb030e11f65@tls.msk.ru/
> [4] https://lore.kernel.org/qemu-devel/20230301142926.18686-1-yuval.shaia.ml@gmail.com/
> [5] https://lore.kernel.org/qemu-devel/8734z9f086.fsf@pond.sub.org/
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Juan Quintela <quintela@redhat.com>


