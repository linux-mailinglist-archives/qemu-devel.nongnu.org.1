Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206A749B04
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:43:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNNu-0005TV-Rh; Thu, 06 Jul 2023 07:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHNNn-0005St-LO
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHNNi-0007Cu-PI
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688643760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vcf7QHKLpBXcPUjgGD0oUcQaTofe75gJXZKJMFB7UG8=;
 b=XAp5uyveZAnxE8mEcZgnnPNftNLpY6Od95kCz64ryhK0f7/p3n2BOrVHU1MsInKOzgoBai
 ri+p3g4Q1wiDPX2huA9npHEyj/JdEv4uCp38ogBkYJHm5YfFFEJH+MP3ZjQK4YN3hQmGKk
 aoROJTKwfBbhCZFPZIZRgnIo2xDsNig=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-MoW_4gx_Ne65vHyszM5tIQ-1; Thu, 06 Jul 2023 07:42:39 -0400
X-MC-Unique: MoW_4gx_Ne65vHyszM5tIQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3143ac4a562so301316f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688643758; x=1691235758;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcf7QHKLpBXcPUjgGD0oUcQaTofe75gJXZKJMFB7UG8=;
 b=PDw3gBxkdfb2/UcSJNM/gHzVrwDNp8m4yNNGyVxJNmXSrFC5fJdKAjWlPsam5jryz6
 0Uu3uxaaN22rtxPtuDfaO6ENgOGnKYMGU/H8t3FbMxTkcJIRKBtK5YFRbgBtXGnUizuB
 7woajjhi9Qw3bt7WSUSqKvdKqAYzaOpJiutG/J5xf0i2iuCF0flx3vmLTCLrT6wSp0Ab
 l+bK8LW6pMq6uxDPBYLwT3QXtllpG0ZgNXPtRkC3nU/vVTq6ZiVsz9CONvW8+60tZ3K7
 HjWYH4nJlbRXOCWT7CES5ILf6dOzGL6ytBHvv2xvl4d8HCcYcGfv6YqFstsNJ+YZ+vKE
 rN9w==
X-Gm-Message-State: ABy/qLbqVlas6DAP7sLAH2iYeB2nqWVzP91Z8H0JWdEnl28cpK4upDzI
 PpqTz2t9lLsdeec1ZnGCzos1L4kvxWsC2LBMu7Ael3J7dxfAK7nYVLuc/2ezazkpDp5FnmWwouO
 auuWIiOv2wHlS+hs=
X-Received: by 2002:adf:e34c:0:b0:314:3643:83b5 with SMTP id
 n12-20020adfe34c000000b00314364383b5mr1217716wrj.41.1688643758481; 
 Thu, 06 Jul 2023 04:42:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkF1wWNx/dq/ctP/3CQIYUFC/XB91GkFvtY5pJ7CDF0xg3ezRE13zqQbHeJsf1dfcgUsnF5g==
X-Received: by 2002:adf:e34c:0:b0:314:3643:83b5 with SMTP id
 n12-20020adfe34c000000b00314364383b5mr1217699wrj.41.1688643758217; 
 Thu, 06 Jul 2023 04:42:38 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k7-20020a5d6287000000b00314417f5272sm1674176wru.64.2023.07.06.04.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 04:42:37 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  qemu-trivial@nongnu.org
Subject: Re: [PATCH 2/2] migration: unexport migrate_fd_error()
In-Reply-To: <20230706102937.82490-3-lersek@redhat.com> (Laszlo Ersek's
 message of "Thu, 6 Jul 2023 12:29:37 +0200")
References: <20230706102937.82490-1-lersek@redhat.com>
 <20230706102937.82490-3-lersek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 13:42:37 +0200
Message-ID: <87wmzd9sgi.fsf@secure.mitica>
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
> The only migrate_fd_error() call sites are in "migration/migration.c",
> which is also where we define migrate_fd_error(). Make the function
> static, and remove its declaration from "migration/migration.h".
>
> Cc: Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> Cc: Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> Cc: Peter Xu <peterx@redhat.com> (reviewer:Migration)
> Cc: qemu-trivial@nongnu.org
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


