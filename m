Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CD873709E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdPG-0006cK-D3; Tue, 20 Jun 2023 11:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdPF-0006c4-77
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdPD-0007Du-Qb
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687275391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xC9OtE2dFL4SacCd/rw5GuHHW40B9QwMT7w8zJ4nEtA=;
 b=bWp7KJhLZ/e2ZtxeBI8uJedm4J4zKR6YUCtGlu01h/60aQjSiQM4Q3QUPTRM0DWTIwQ/GQ
 tYK94IoIBqDrDbNGDg//rN3tGx+S/2rQqIXxtQFpLbA1uWPHhCQKdNoIJQ4NgzHjRXZMXc
 xJgi1DyH4/fsx8cQMAsyRknoBzP+x0g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-hKMmbBjsOIGxvN9sJa3nsw-1; Tue, 20 Jun 2023 11:36:21 -0400
X-MC-Unique: hKMmbBjsOIGxvN9sJa3nsw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7606a134623so80394585a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687275379; x=1689867379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xC9OtE2dFL4SacCd/rw5GuHHW40B9QwMT7w8zJ4nEtA=;
 b=QmOc4P590L6kWUrfZ6+DE9FewV+AW8w9zUWLl55ihsr/TUd+xEGEJnK1c0+61oqI68
 FPVORetrHx4jHuwZuws8l74XxlI5uVinuwQeisXapXADsZ2vTueXN5su8CTH1s8Gy54i
 wJLTGMnyra82H05i3ttBHGMdxDLrS0xNludBTdL3ET3JPt0OyMgpq7tuzy154BZzOl8m
 +dDBXSbPRjxpbnMwuQPZYXSqqEedgMlYMWcx+yREhZKVNlzoOFC4rsOi2/PuCDpvi6wu
 I7uVENVeOhQMPje9Q/3Xc98ChrErRwntDmrU17fYUuztloV06TVyXoeRHFZ0hSZXziZ8
 bXjA==
X-Gm-Message-State: AC+VfDziqTsMr+beJDUnQg9lYNNo19L3315WncsHrot7QHFdulrdu9RE
 qAHkijlPmDi59WCclfYlD8R8gcBXKscJm1zeM9Y/9uhCTsS3+2kdzsrPNBvGp9VofdUYQcuT1EX
 aipm34LO4ba5+vfQ=
X-Received: by 2002:a05:620a:4502:b0:75b:23a1:69f0 with SMTP id
 t2-20020a05620a450200b0075b23a169f0mr17350521qkp.7.1687275379681; 
 Tue, 20 Jun 2023 08:36:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/DsQsyS0/CmhEt31eTuTvU/8/tbnh1K39Y3vxGSnUp2q4JFul//GHzP1Vgokv1gytSTkcRw==
X-Received: by 2002:a05:620a:4502:b0:75b:23a1:69f0 with SMTP id
 t2-20020a05620a450200b0075b23a169f0mr17350491qkp.7.1687275379303; 
 Tue, 20 Jun 2023 08:36:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j2-20020a05620a146200b0076223cde82bsm1219717qkl.85.2023.06.20.08.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:36:19 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:36:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 15/42] migration-test: migrate_postcopy_prepare() always
 return 0
Message-ID: <ZJHHccWxlYO9zk5P@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-16-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-16-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:16AM +0200, Juan Quintela wrote:
> So make it return void.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


