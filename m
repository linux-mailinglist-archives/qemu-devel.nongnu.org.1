Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A6716782
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41Yu-0007sk-7q; Tue, 30 May 2023 11:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q41Yo-0007ru-Rd
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q41Yn-0005cT-9z
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685461615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pmr6MD2p6Nq9Ny0Ab+yP9Ypp4NmhZaUR0mTkVbcsKHA=;
 b=ZgNksqnFyRkDPl3YK+29mVgeGK6QsWTnKe5kl9c7hnGTdjcudcA7ipJpnH43d+MEJAvAmS
 5QGVX0ndMw/ABTNRlOID0oTA24zpinJKW3383U3i2GcArPjt/RRczRsbw62a+vPYzRyAnr
 dCruIhhFfaem8GDE9MP4Jbsw0uBedS8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-K8oxzWrQMUGQV2Aj-fdZ3g-1; Tue, 30 May 2023 11:46:53 -0400
X-MC-Unique: K8oxzWrQMUGQV2Aj-fdZ3g-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f6c58d57adso9667051cf.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685461612; x=1688053612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmr6MD2p6Nq9Ny0Ab+yP9Ypp4NmhZaUR0mTkVbcsKHA=;
 b=FnucSBoQJKGWgt2He+am6OePsma+l7FCiyD2Fk2em+HL8BQkjo9e7GF1sQzgOiKmVO
 HSAF0fqXsN2HBB/6TSeJTyNDiUv0m9DQo4vUD+fPnEB1Etb/1P9mi6uBJslHRhx1bVUC
 IC2jl39cQej/6E+PkOTuGqPh0MTN4qevaN0gISkd6xHSLRygZAgW6wYuTmNckH5b9OlI
 na32Q2G9Q1LrKTwohAUTf5hqv4KszN0xRkLouNIo/0gAdXNCpYzlWaMEt5aWLY349+fh
 0SAu5JUev0aP786CBALmS8Gap8ZYL0wgijNWYrHwL1V0ECga8crFsMvDhtyB4PYxsMnu
 0s+w==
X-Gm-Message-State: AC+VfDw+6K11hXd+wPgCdqlQ+UDkxKlBViqbpCJu90vaoJP8jJqy/jv4
 U7YWNHWppl1ybhe7uLFwwji2msqmB8RlQfOHvNChAuVAVqWN077e+fkUImUiQ4UQtO8dLhGx6ge
 aNEIUA1cK5l3hHTE=
X-Received: by 2002:a05:622a:4e:b0:3f7:df68:7b09 with SMTP id
 y14-20020a05622a004e00b003f7df687b09mr3124867qtw.6.1685461612282; 
 Tue, 30 May 2023 08:46:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SU1+X/IIWU3jmJ3PxRL2ZjCyba+WaLwuYKrz+lWsmUAEeyFWmc4lt0A5qsWh8aD7E5Xe0NA==
X-Received: by 2002:a05:622a:4e:b0:3f7:df68:7b09 with SMTP id
 y14-20020a05622a004e00b003f7df687b09mr3124842qtw.6.1685461612008; 
 Tue, 30 May 2023 08:46:52 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 d4-20020ac851c4000000b003e4d9c91106sm4746365qtn.57.2023.05.30.08.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 08:46:51 -0700 (PDT)
Date: Tue, 30 May 2023 11:46:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, eblake@redhat.com,
 armbru@redhat.com, berrange@redhat.com, zhengchuan@huawei.com
Subject: Re: [PATCH v2 0/4] Migration time prediction using calc-dirty-rate
Message-ID: <ZHYaajucX3WbO5oW@x1n>
References: <cover.1682598010.git.gudkov.andrei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682598010.git.gudkov.andrei@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

Hi, Andrei,

On Thu, Apr 27, 2023 at 03:42:56PM +0300, Andrei Gudkov via wrote:
> Afterwards we tried to migrate VM after randomly selecting max downtime
> and bandwidth limit. Typical prediction error is 6-7%, with only 180 out
> of 5779 experiments failing badly: prediction error >=25% or incorrectly
> predicting migration success when in fact it didn't converge.

What's the normal size of the VMs when you did the measurements?

A major challenge of convergence issues come from huge VMs and I'm
wondering whether those are covered in the prediction verifications.

Thanks,

-- 
Peter Xu


