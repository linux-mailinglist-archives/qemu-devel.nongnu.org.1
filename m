Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CBD7400C7
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBRI-0005eb-Rq; Tue, 27 Jun 2023 12:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEBRA-0005cz-6V
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEBR8-00025L-QM
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687882861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6zDAD7GLeWfNK5Ok1iEERzjkvEtxeHfrjAkVeUePXQI=;
 b=fjw6eKzgG1g8NGYpIn/p9LsQ/QIXD4sAitcGSF+eJSGsmUPIi/iiz7/2ECPdrDHGbp3Q2Z
 Lo4SMfafUxvPa+ZsvUqWWo9WW1k727TxQ9EqBEOEKYPxIj+wyU8uDbatkvuJVvU2WYH0pn
 n7VA5F5i5tvrsfxAeltfumKvIvI2i3c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-URNwapbIMV-5XEy6mSDaQQ-1; Tue, 27 Jun 2023 12:20:57 -0400
X-MC-Unique: URNwapbIMV-5XEy6mSDaQQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-40234d83032so2339241cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882856; x=1690474856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zDAD7GLeWfNK5Ok1iEERzjkvEtxeHfrjAkVeUePXQI=;
 b=U2y92kcIOoRYPBaPn/cXXc7z7xVeIrGqCocVY+oknuvjyK4Ad4eTkfF70XBzFf215s
 d1uw/Dm6WvvNN7SQIs9m7RxaHuGN2wqk8w6k3NYHgdRfCg5LvOwYxRCQtKpi5/z+Or6Y
 F90u9kopOw2tbJFx6BTL7reVqJTBTzWWejxAABSkMUTSXwnhu6+m3Lo+1z3o8GuzGhK5
 wnXREaGeI6mQZsB31mV/1AvxKu1c3y/8aH3QC40UpIDtxKF9PEmAH3rTxu3MW8oDfahf
 x4Rl2h2zGOJ8JdziUjW6tFC0uy3WTdKXGlPkVqd/fAhI1SuLGs/xMczaBIdECnHhOmE3
 EZWQ==
X-Gm-Message-State: AC+VfDycYkKPpSYfRBNgN9rxO/TgBQeKx7PKdOqLivRmBKhFQHTVYueO
 GJtvoXyeHCc9J8DDXe+ZbNQaMwqocMxwbuuWch6KlGtCYG+JjpPQRgcjx9MBTfVSover4dowgBb
 r3ncBqLEaZD1UCW4=
X-Received: by 2002:ac8:5915:0:b0:400:a226:3168 with SMTP id
 21-20020ac85915000000b00400a2263168mr8411302qty.2.1687882856561; 
 Tue, 27 Jun 2023 09:20:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54pYjE1fAnrXlsIAb1MJqIj9NNxuKyjiDu0X7KVd3Qhlf3rA5MOXt/46nbqS+pu8+AxZ2BBQ==
X-Received: by 2002:ac8:5915:0:b0:400:a226:3168 with SMTP id
 21-20020ac85915000000b00400a2263168mr8411279qty.2.1687882856266; 
 Tue, 27 Jun 2023 09:20:56 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w14-20020ac86b0e000000b003e388264753sm4640076qts.65.2023.06.27.09.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:20:55 -0700 (PDT)
Date: Tue, 27 Jun 2023 12:20:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 1/5] migration: Use proper indentation for
 migration.json
Message-ID: <ZJsMZn95GTMCi2H4@x1n>
References: <20230622195019.4396-1-quintela@redhat.com>
 <20230622195019.4396-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230622195019.4396-2-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 22, 2023 at 09:50:15PM +0200, Juan Quintela wrote:
> We broke it with dirtyrate limit patches.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


