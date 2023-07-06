Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C78749B03
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:43:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNNY-0005Rr-KK; Thu, 06 Jul 2023 07:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHNNW-0005RU-95
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHNNO-00078B-NK
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688643740;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JUduR/Bwi1v0roLeHwv+HCpk0DV295GfQxEuB4DbDNQ=;
 b=ZLcceBpOjD/Zj5GCJ8/rlXWOhwsp0aHeqlG3maLNAinnkoZRkDJM2cpuVwnTlUd8W4rq6R
 +wSHwNE6ilVjk3a304GifUU/Sr8+0WrRyoAv6uXnhul+yzG2etRCSA2+OuIJ4mpzfJNKDU
 Bmrz7omhRBox+lAk/iEyIvKUYnaDsEU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-cirlpwgyM86zHCThgGhXHg-1; Thu, 06 Jul 2023 07:42:17 -0400
X-MC-Unique: cirlpwgyM86zHCThgGhXHg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbaade0c71so3490435e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688643736; x=1691235736;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUduR/Bwi1v0roLeHwv+HCpk0DV295GfQxEuB4DbDNQ=;
 b=apvV2wihK/bMoKCDHDnsky9ethgstvtOvu61pGJSWluBZyY61I5QRtNwYs/YHmwpbW
 i5LhuqhA8dkmgpAktlErRQYCvo24DH35IJPA3cnA42FaGWnoT4uykqBpE/KeJADOhHHr
 9RJZpWc98Z3NIUqeahSq8gI3sAs8mCk7xF4xtimCIgEjzITp5sWfO79gaQaCkgGMBdTq
 F/iKorUnsmhfD20ks2Q4WGrH9gVjhMQXYZ1wtRTO73rr4t+fsPhSn5a7dwiEdkk3UqCZ
 v6ab6TI5cYtHJVYUlaq8umvKx2gFrGPlRRRr12plAt+SXeatcX1KM7QzKLnw6/4svGeH
 21uQ==
X-Gm-Message-State: ABy/qLZ4D8vT5Y4KSfzCa32XQHXMgOoO4Qe7b+zgl1L6E4FyXaW/WnjS
 jBbjTb4GIfgcNxZkK9b8PsRcSsnZAZTgW6zWPgjfEzNMlf5xAxVEDWZRmcPQ+3Wog6fXwwMDvut
 FsBhrz+UkZVisTkM=
X-Received: by 2002:a1c:7204:0:b0:3fa:9767:c816 with SMTP id
 n4-20020a1c7204000000b003fa9767c816mr1047870wmc.39.1688643735927; 
 Thu, 06 Jul 2023 04:42:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+gQExkVZ4+CA7TY1ttMMPhnJGDCSd+dTPylauck7BugEXiRpbGJCJeLQYKC/SAuOOnljmsw==
X-Received: by 2002:a1c:7204:0:b0:3fa:9767:c816 with SMTP id
 n4-20020a1c7204000000b003fa9767c816mr1047860wmc.39.1688643735643; 
 Thu, 06 Jul 2023 04:42:15 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k21-20020a7bc415000000b003fbd1c8d230sm4908129wmi.20.2023.07.06.04.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 04:42:15 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  qemu-trivial@nongnu.org
Subject: Re: [PATCH 1/2] migration: factor out "resume_requested" in
 qmp_migrate()
In-Reply-To: <20230706102937.82490-2-lersek@redhat.com> (Laszlo Ersek's
 message of "Thu, 6 Jul 2023 12:29:36 +0200")
References: <20230706102937.82490-1-lersek@redhat.com>
 <20230706102937.82490-2-lersek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 13:42:14 +0200
Message-ID: <871qhlb71l.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Laszlo Ersek <lersek@redhat.com> wrote:
> It cuts back on those awkward, duplicated !(has_resume && resume)
> expressions.
>
> Cc: Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> Cc: Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> Cc: Peter Xu <peterx@redhat.com> (reviewer:Migration)
> Cc: qemu-trivial@nongnu.org
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks.

queued.


