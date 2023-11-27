Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5069A7FA387
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:52:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7cwz-0006vO-83; Mon, 27 Nov 2023 09:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7cwq-0006sE-L4
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7cwj-0003hO-N7
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701096647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0AUSjpjCl2wK/h/idQ9XM6jVCPdfJIrap7W5qcqf+CI=;
 b=cUI1qfSV/6Cb/yd2gRwcLMtlLE4EtcI8HZwqlq/IBsOwZ17aFrGgbfN01RuMM9lA1BXL2+
 324xsbXZLu3mgu0v4ocVxiE6N2vmSYQXAFG8PXSc8jGphgpDIJrCYDWPLyvz91zZlhkS5g
 c8Nm+LbPwuvtoHq/FzKt0W0ZXDUATBs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-o47Yxbl_NBOr8A5Xtt714w-1; Mon, 27 Nov 2023 09:50:44 -0500
X-MC-Unique: o47Yxbl_NBOr8A5Xtt714w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-423a6c92800so3846451cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 06:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701096644; x=1701701444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AUSjpjCl2wK/h/idQ9XM6jVCPdfJIrap7W5qcqf+CI=;
 b=vph2FGAJ+Ymfkk40WEBG28kV/CGnjrqnpL47wf7UScabN5viwi84V7TnPmp1grlaI6
 ruY35CeIaO3mHHVeOXCQKDhb7S7YQoPPeY9L+RXWP5fJ3m9lGqLqZaR6gQStHv+ehQoi
 HDwFEuSHlia8I6u5rvRKK3QwFtpHBefTqycRBwsxo/U/ZhVA2DiLTy7367oSODgZIFlO
 WHXuLe/6MUoWO9HcQjG3suoqtCQyRY7iAe3lRfOZDkYKjon1QWYohkIwNEdcEGelBzR5
 4/973xjsewqLv+tJQp3S4K/ybnfIAXlZN32DfWkwvlm3VrWO3GKuEJFweeShtKp50Ylm
 TSNQ==
X-Gm-Message-State: AOJu0YyR2lfNkfH44iRpWbmOHhKTQG8hmOcMvanVLeXS8MahPQ/pLcKI
 bbW6PwuNuiy3NTqgAQdgpuT58rwY3Cj4Sd7NJA61ca1wMYUnu/JL3ocIur5+hDrkF9JJVxyE7n5
 mybJqs3mnMSAuKCc=
X-Received: by 2002:a05:622a:211:b0:423:a073:8940 with SMTP id
 b17-20020a05622a021100b00423a0738940mr12716140qtx.5.1701096644210; 
 Mon, 27 Nov 2023 06:50:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJnWV0f9pandj7SKCqINqttwLINJuiZcjUZwy7NhYgSG/raW0t2yCPl/kS9nTxbFvBn3zFEw==
X-Received: by 2002:a05:622a:211:b0:423:a073:8940 with SMTP id
 b17-20020a05622a021100b00423a0738940mr12716111qtx.5.1701096643838; 
 Mon, 27 Nov 2023 06:50:43 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 l9-20020ac84589000000b00421c31faf05sm3792545qtn.1.2023.11.27.06.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:50:43 -0800 (PST)
Date: Mon, 27 Nov 2023 09:50:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 5/7] tests/qtest/migration: Print migration incoming
 errors
Message-ID: <ZWSswkonmoz2ryQu@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124161432.3515-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 24, 2023 at 01:14:30PM -0300, Fabiano Rosas wrote:
> We're currently just asserting when incoming migration fails. Let's
> print the error message from QMP as well.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 24fb7b3525..f1106128a9 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -118,6 +118,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>  
>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
>                      args);
> +
> +    if (!qdict_haskey(rsp, "return")) {
> +        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
> +        g_test_message("%s", s->str);
> +    }

This traps the "migrate-incoming" command only (which, afaiu, only setup
the listening), would this capture the incoming error?

> +
>      g_assert(qdict_haskey(rsp, "return"));
>      qobject_unref(rsp);
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


