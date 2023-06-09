Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A67296E3
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:31:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZOL-0005SQ-Cu; Fri, 09 Jun 2023 06:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7ZOH-0005Rw-Gv
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q7ZOF-00068l-Nh
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686306642;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/jgWPcLYVmE19WNJlL8CfPdjuyqbrrnpvkW3oE8xqFI=;
 b=Z1dxqwg1Tc1SzxkoAU5v0oz+Dy+sdqtHF1yRY2BaOI/I7AWtngoyD2GUZisU5QfzBQX27x
 AGFNUm5SXi5WjNA5BgdneMpe8/XDZ57oeIwd9nvJfaHR4L58+DmY4VtMksgQcSt3b57aB6
 8w/GBOSt4W1GMXCqz0RpjIOPlS7ZyDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-BbEVw58aMS2Hsf_da0WJ1Q-1; Fri, 09 Jun 2023 06:30:41 -0400
X-MC-Unique: BbEVw58aMS2Hsf_da0WJ1Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7f77ac6b6so10550115e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686306640; x=1688898640;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jgWPcLYVmE19WNJlL8CfPdjuyqbrrnpvkW3oE8xqFI=;
 b=GlPF5DG9v1beselTu5/Y6ghJb6JsOIh4aAQNNwYwoaFdNuoQHgAtpyZgNqWeYZn2xB
 9AR3gSE6twP4DHelFCDZl/1AruI0DTIfQfF4DYuFrTvkq3KFGOeSS0malrcQl8Wcx9mZ
 tVp/Gx86MWfbl/oM1E7VfExPKZL9zMwbl/M9TCKU3GNuLA14tTzWT46l+BXlnIavNCiD
 WAFq43abmtjlbGvOkjND50ZvWoYPl6F/fPcRvpPgfYWOeT+Xhi6IYAK/v5NzwefGfwOi
 C+Tv5oqzko71thEH4qqUxj4R11SSGYCBxLikVTkBcZdnGiAH8Jl0MW5BysJ76fw2mbDv
 e1jA==
X-Gm-Message-State: AC+VfDwFQk2QDzCcC28hq1aIt+Lg3pAZAzwpfZYwvgJ8Al8j5YHxTB3c
 R9SPvYty74Z2shQamkmYBNc0L9FfMLjt/ocCEbR7/DYRrgAwSKjA90OZK1zwN6BVLv5hM+PNHyq
 eH3tSnLzZJB4MJ9Y=
X-Received: by 2002:a05:600c:202:b0:3f7:e809:f41d with SMTP id
 2-20020a05600c020200b003f7e809f41dmr882991wmi.4.1686306640392; 
 Fri, 09 Jun 2023 03:30:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OlSjTPkJ8aRNE5rrQv6ftIHhQqDpAD7MoqdQy5pAolJORyF1wvy9DpmPmSTE6FIGe1+n39w==
X-Received: by 2002:a05:600c:202:b0:3f7:e809:f41d with SMTP id
 2-20020a05600c020200b003f7e809f41dmr882977wmi.4.1686306640148; 
 Fri, 09 Jun 2023 03:30:40 -0700 (PDT)
Received: from redhat.com ([77.211.4.233]) by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c059300b003f60482024fsm2215543wmd.30.2023.06.09.03.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 03:30:38 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Jiang
 Jiacheng <jiangjiacheng@huawei.com>,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/3] tests/qtest: Re-enable multifd cancel test
In-Reply-To: <20230607161306.31425-4-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 7 Jun 2023 13:13:06 -0300")
References: <20230607161306.31425-1-farosas@suse.de>
 <20230607161306.31425-4-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 09 Jun 2023 12:30:35 +0200
Message-ID: <87ilbxc4hg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

Fabiano Rosas <farosas@suse.de> wrote:
> We've found the source of flakiness in this test, so re-enable it.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

See my series sent yesterday.

Your fix is necesary, but we still have another failure.  If it takes
too long for "to" guest to die we could be waiting on the wrong
"dst_serial".  See my series that I sent yesterday that fixes this.

Queueding patch 1 and 2 for next PULL, waiting until my series get
reviewed to put this one.

Later, Juan.


