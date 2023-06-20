Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E75736FBC
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:04:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcuS-0005mV-2S; Tue, 20 Jun 2023 11:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcuO-0005lw-R7
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcuL-0004Un-Id
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687273476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zm5MJV9sLfwJ8ks4nmg+qTjMPAC03jb3Nu2VPykip08=;
 b=X9dxWt7eiF7X4jyAP0mWYhWt4BZ5CXvH7Gejo9qxx/U3sudYhW5Lsp5fohE5ZmWjpou6Rq
 vj/AnOyfalDIdDjWGp7BmBXqKUZSI3mXkBDqI2zX5qI19UH0JCkN/E7qT/chB811Oe5OiG
 EDoRGvilEtyCoLXmxiFtZtw+Kj4ArM4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-q2H2hcinNRaCKYfUbH2Rlg-1; Tue, 20 Jun 2023 11:04:16 -0400
X-MC-Unique: q2H2hcinNRaCKYfUbH2Rlg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7639e09a3a8so39516985a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273439; x=1689865439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zm5MJV9sLfwJ8ks4nmg+qTjMPAC03jb3Nu2VPykip08=;
 b=P8vjxVCeDFnX0eGiue3yZZ2FGtNXsAaLv72pfTz1xqf5tsXuen5LL837ccr5q1tKOy
 7DbmqIDd07TL8XjmIMNRAKecM8l7c0JWqnpGINrS7uE8HCfVKQelcXa7aNzGslDdxNyc
 sR0iRZCKhlXGIk+QLCO97vdo/VOH6F90fJ+dpHFN1C0YuHCZ2iwIZSTPghyhWHk52Jd9
 m8Oo5OdmOQ4wDjgK5aswK/IUVGPj+JqjCLN+kujVghIYG+nX7MZfRjeQn6hDvBjG4rEC
 Gk3oQfBsagkaBhRYbCV05uDldGoxeHQhEELwJbvCckphPJMEhFxNYNAiX0PsZN9C3oaA
 pXcw==
X-Gm-Message-State: AC+VfDwMiZjrIagD7JgH8UxEI6+zBnCYobcIMSCQ+JmZqjnNyS+uo/JT
 nf0/Bkeoeq1x9S/BKWc/5Qiu1hzB3OG9jd2PVhsgHn5lFtK1jowJrs6ZeoKImVoKZ+tZkAWlFHd
 FDoKObO+9hfj3USs=
X-Received: by 2002:a05:6214:f2f:b0:62b:6c6f:b3e3 with SMTP id
 iw15-20020a0562140f2f00b0062b6c6fb3e3mr16363223qvb.3.1687273439286; 
 Tue, 20 Jun 2023 08:03:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MeQJuUhkvlVKlv+x1Bm1B1RL/bXecISWyzRQuXvpf16wqPN3pJDDVN/DKhJHcME/AvieWDQ==
X-Received: by 2002:a05:6214:f2f:b0:62b:6c6f:b3e3 with SMTP id
 iw15-20020a0562140f2f00b0062b6c6fb3e3mr16363197qvb.3.1687273439082; 
 Tue, 20 Jun 2023 08:03:59 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 jo30-20020a056214501e00b00628274a709fsm1336974qvb.47.2023.06.20.08.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:03:58 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:03:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 04/42] migration-test: Make machine_opts regular with
 other options
Message-ID: <ZJG/3U2baundFWxE@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-5-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jun 09, 2023 at 12:49:05AM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


