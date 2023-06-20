Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD6F737062
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:23:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdBY-0004qD-Bl; Tue, 20 Jun 2023 11:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdBU-0004pI-3s
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdBS-0001Dt-Py
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGbhxxHbnPrUEW3QUWfLKCqfzqoF0qDPi9nWOyrRyIw=;
 b=Y08eRzcpG9FQEWUsaMQKCfaUO5354Xf0NMqoeIiLIKlOBzL0w8qwRlgPOxOGaYaSwxNxiT
 e/qIzXVQj9+nRMnr4U0rAuihuD/Z1Tn/OL9PPKqtOV3bFLikcDE92U+TDLlA4oWkO0bo/P
 GQFvBr4lJW7ta+ulxNy7KP9njvAw/Os=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-Wx3mrP1SN1yz1Z0lw4QOnA-1; Tue, 20 Jun 2023 11:12:22 -0400
X-MC-Unique: Wx3mrP1SN1yz1Z0lw4QOnA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f8283a3a7aso12123231cf.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273914; x=1689865914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGbhxxHbnPrUEW3QUWfLKCqfzqoF0qDPi9nWOyrRyIw=;
 b=Qb+S2+C2mBffkkqS4L1szKTDr3ZbPNUt3MOvWsVinK4ZXFNJ818cBB2MjLuMqI/od8
 CnLcr86AHy+iu4q4n5m4fb9aw1V/qLMISIOP1U9ohTRs6NNXLh3gYscJRy1FSVpzayYN
 QzvxrJvh27ilPZ5l2Ccqh6hbMhvmLOLwc1KpQR+4uZXogBShe6lI8ByPJjjvf93WKLM5
 rOQZ1yfiEWLi29uCou3IewCqFr9NOE+V/rfndSUoYO9oO+I//aaPLIEVJMpK5xqX9sMs
 qAyTuDUgCso03O8HGr1KnNVz8+Fmx8/d8iWR01CP1ecR/DCwm4bzZQ4jgUzflg3DLlzl
 iCcA==
X-Gm-Message-State: AC+VfDy8oR8bHtj7a0jbOOSVJjclOKCsO8kssiYsGGTbgZ0spxYR+Gy0
 4g0WdASI4dNuxSr+p0mLwp4Y4kA8TQZedEUclW4imI8vKtTI0bJlz9vqOJbfsA1zCPv/69XCDOO
 0b4GxKAuTsUrdJ28=
X-Received: by 2002:a05:622a:612:b0:3f6:a8e2:127b with SMTP id
 z18-20020a05622a061200b003f6a8e2127bmr15085846qta.5.1687273913802; 
 Tue, 20 Jun 2023 08:11:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7oxFZNEc436PK1GQ7CMfwzOWMzMy/w9DaB+kglCSVn6CvMcaxUDw5/SL+cvLrPV1+Fremy3Q==
X-Received: by 2002:a05:622a:612:b0:3f6:a8e2:127b with SMTP id
 z18-20020a05622a061200b003f6a8e2127bmr15085829qta.5.1687273913568; 
 Tue, 20 Jun 2023 08:11:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y1-20020a05622a004100b003e0945575dasm1225771qtw.1.2023.06.20.08.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:11:53 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:11:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 08/42] migration-test: bootpath is the same for all tests
 and for all archs
Message-ID: <ZJHBt4ywEc80d7Vo@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-9-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:09AM +0200, Juan Quintela wrote:
> So just make it a global variable.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


