Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E8380C193
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:55:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCaBO-0002RK-Uv; Mon, 11 Dec 2023 01:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCaBJ-0002PZ-Ux
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:54:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCaBI-0000Pk-HA
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702277659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u0qclSomRfJCAUSOx3ArPM4MHRuQOVH8D3zGbL+awwk=;
 b=LpQClI11z+aYaGSvRd0pYCYf4xle8cHyMw4aYI+9Yo5s09bP42dKD3uqa46u8DM5Ne6ghy
 0LZwZmkda9TDq2QYNkuinMOQ/bP4tW+b+OTb90XurDbRfK6295R8YWEN9YYg68NbCphCki
 zUz+heWNAFKIWUpQ6epIzYFq/AKtAg8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-4v5hOFZPP0Gk5n6Fvrpw8A-1; Mon, 11 Dec 2023 01:54:17 -0500
X-MC-Unique: 4v5hOFZPP0Gk5n6Fvrpw8A-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-286e9b8443fso1516636a91.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 22:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702277656; x=1702882456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0qclSomRfJCAUSOx3ArPM4MHRuQOVH8D3zGbL+awwk=;
 b=g4hFYuRoKsASpvBlmJaDtwSwPQI7iDVnHdfYTRkLDW9l1Pk/zfCWU6s2YmasW7StVy
 sqk6c0mBpQXknJaXR0lR/h0KYwupWrXiMtnIZfCH5Mcgd1+ubd9sXvzKMI0AdCrgty26
 BKGJT/9ZXAqWJWaGp2+qNHlisKr1A+fXQrh9Xm7IPOexo9f6Y/ImcS3nfOyirdPU+qRu
 qWCEvEWyZL0YhtUQ0wLV8egrkZgOdz69rThrKfyfP7ne8t7Rl9FRUwn/uK7Frp7FbcSZ
 US9KOrbn8RAHLZ59wB8vXI2QSh1ulrozKUAmNsSKJ7V2dXm/f8KBnxlGVdNJTHaNPDFc
 346g==
X-Gm-Message-State: AOJu0YxKpP6lYE1NXNaMsIwQnCUJhLdU3sqj7w7eRfKiZ0XnBW/7NZuE
 etUQimECnzcxuNGU9F38UWuPnQ+SuTvTgrVRFD6SwRxbOlrt1Q69gJrgO2cSzisvcWfKG7ZpCfT
 VRGBjp9alzujIkF8=
X-Received: by 2002:a05:6a20:548f:b0:18d:4821:f75d with SMTP id
 i15-20020a056a20548f00b0018d4821f75dmr9641475pzk.4.1702277656674; 
 Sun, 10 Dec 2023 22:54:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsyvSNPOYexbV/pTSiNQC/OQJ/gpXomRGmM1sqeHl9KUxkOia9BRg0LQU4ra4G6prMeRSUAA==
X-Received: by 2002:a05:6a20:548f:b0:18d:4821:f75d with SMTP id
 i15-20020a056a20548f00b0018d4821f75dmr9641467pzk.4.1702277656442; 
 Sun, 10 Dec 2023 22:54:16 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j4-20020a170902da8400b001d072591d77sm5815839plx.247.2023.12.10.22.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 22:54:16 -0800 (PST)
Date: Mon, 11 Dec 2023 14:54:08 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V7 11/12] tests/qtest: precopy migration with suspend
Message-ID: <ZXayEDwUiMzwM2Ga@x1n>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-12-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701883417-356268-12-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Dec 06, 2023 at 09:23:36AM -0800, Steve Sistare wrote:
> Add a test case to verify that the suspended state is handled correctly
> during live migration precopy.  The test suspends the src, migrates, then
> wakes the dest.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


