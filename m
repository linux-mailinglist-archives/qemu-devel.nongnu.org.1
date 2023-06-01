Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A771F6CB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 01:45:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4rxW-0005HS-Nd; Thu, 01 Jun 2023 19:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4rxP-0005Dm-3l
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4rxN-0000Ut-G8
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685663027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ENKWbPC6eauYMq2OLdmfI92FLlFJyhLU1OkBxxz1cc=;
 b=URuUN0AwZb2U0Zq3uMogWD+RZlRk8dTB6x6NLtElHTt8SxWkmFfET9+9gLJ4gUe62c9jxK
 sDfXac7a9gLkZwTA7CsZhgd/xzji8EHrSmA+PFTfW2gY2rkxXBXnbcFg5RciRsXnxmPn17
 ith08VKuCRLbob5t8tiEI2MZQGFpSzI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-yeD6S1zCNvGwSQHNEmHkxg-1; Thu, 01 Jun 2023 19:43:46 -0400
X-MC-Unique: yeD6S1zCNvGwSQHNEmHkxg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b337f2504so8189385a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 16:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685663026; x=1688255026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ENKWbPC6eauYMq2OLdmfI92FLlFJyhLU1OkBxxz1cc=;
 b=G2nxZTg+tOtryH/p3ot4Nxz9ZUZEVlq9FeZHQng8Am2su24DUnthKTarjVszCGjP48
 Vj+3PUIF4ogKndSzR3jH8OuUgM5BDQhBMjh8Miur4smh9q4FC6mw5AaanGlkHk8pMQ98
 6SjvCHDGCiK6aAPOfG9/ggU1kSdZzA6Bh2sryFgvBaTIhT1QAEZPXPlowDUhfLipPrYU
 m1IHtsQtwR3U8ntTANLv9ruN3SH7kyxMxsdWAHa1hqec0pv+7RTFESqmhOvfy81iBhxW
 9IuTaMhtD6+qQBcCzkRyBA3qgDb2Iazmy3V1WQ1zbmaavinBsU9BoFp3sKVdbwhnf7wt
 Oeqw==
X-Gm-Message-State: AC+VfDzL0/e8UkKAswwrJNPs9bh3dcNW1n+yFgR93tOAt2Mu31BqF8LU
 dnagonHtVF0NOt8yLyidNgm197fN+t783GyKhgpcT4+K02ruGfgKcMM9c1i82olyKuAs2JBA453
 t6CJwk3CVkZ/+bzA=
X-Received: by 2002:a05:6214:300a:b0:61a:36d6:41a5 with SMTP id
 ke10-20020a056214300a00b0061a36d641a5mr11760909qvb.5.1685663025790; 
 Thu, 01 Jun 2023 16:43:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DXAvoafUVGyI3fP6UIDruRwgrp9VYg7JFZh2hIjaQZLS3QYLZz6P1FgIZu7fyeNdnaTxUVQ==
X-Received: by 2002:a05:6214:300a:b0:61a:36d6:41a5 with SMTP id
 ke10-20020a056214300a00b0061a36d641a5mr11760887qvb.5.1685663025509; 
 Thu, 01 Jun 2023 16:43:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c1-20020a05621401c100b005dd8b9345dbsm50489qvt.115.2023.06.01.16.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 16:43:44 -0700 (PDT)
Date: Thu, 1 Jun 2023 19:43:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 9/9] tests/qtest: massively speed up migration-test
Message-ID: <ZHktL1tZwSmT+Pcn@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-10-berrange@redhat.com>
 <ZHi9OQz8PGuHMPpN@x1n> <87353ardol.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87353ardol.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Fri, Jun 02, 2023 at 01:00:10AM +0200, Juan Quintela wrote:
> That was basically my idea and that is why I am holding the last two
> patches and see if I can came with something in the next couple of days.

Ah! ...

If you haven't started, please hold off for one day.  I'll see whether I
can post mine tomorrow.

-- 
Peter Xu


