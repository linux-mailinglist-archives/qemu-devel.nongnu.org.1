Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D323B73706D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:28:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdGw-0001Mf-Jn; Tue, 20 Jun 2023 11:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdGs-0001Lf-PP
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBdGr-0002yw-6N
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCxa74ZDcHnFN+nf+6FFsorXf8XppLHVWUwTMZS7egY=;
 b=TeWKF0JU+pTo5APWECjez3SEKOKGHxb9vCz1MRE0BOrBe5VcsVZSyWrShxXWh8O6pwLqKt
 gSTkRRdkMsU+88HNaEqC+oAvYs36a4s4lY9SF1o5dyBf7Jk3JPFluqDpmNgI9p5JIJYmYB
 f8En/5D78l+GlzQWqTSxn7lO23PwreM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-FuuaG3wJO5eZtfF_--ylEg-1; Tue, 20 Jun 2023 11:27:46 -0400
X-MC-Unique: FuuaG3wJO5eZtfF_--ylEg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6b2c3db1920so398366a34.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274864; x=1689866864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCxa74ZDcHnFN+nf+6FFsorXf8XppLHVWUwTMZS7egY=;
 b=IKQtYzkulbF8owej6whUAfoSl/lAh7/GJu6jYAPp17yuo/YJPFo8iVIcy21LK2w4gI
 mb6gjwjZfB/th+yXqf2cqauqtX1gLt9Lr/5MwAX7fNPv7CCYQrjVK8TS16U0RnCjbXiW
 4wVy5jKfTN58fxFdgDYviTuHqeJVG23OBx7MdMzMIEVxWDLMiX/0U7GnczpV025dtcFc
 Ifm0uns/SYEgQDdb3nsipDaQdfjVywbo+/lFXzs6X32uh2zbPZlsDeIDQnFAkO/d2Q8q
 lTlz5YINPf4J0oo6RtW5onET1G9k2n/o6f6EYRbaU+PnMo1giKuLnz+t1SCVoIhtwyHG
 xWsg==
X-Gm-Message-State: AC+VfDxfJqOQncGIPpoub41Hwo9FhUuC4hqUJ7kzd8D2pWZJT9egAj2W
 8T+FU8KWJNrL7b9gifkipPhJVArqP6taXKKWy0+UgEpE2759CiEegNkAfPBFJL1g1mcPds+qO+d
 ZdHf+rsvb+U5cFtI=
X-Received: by 2002:a05:6830:4607:b0:6b4:5571:6021 with SMTP id
 ba7-20020a056830460700b006b455716021mr6723399otb.0.1687274864198; 
 Tue, 20 Jun 2023 08:27:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kyr5iEH0JIDN3KCymjZWUDJ3bboVHXnfCs5wqRjNlrpx9eWgG4pH8sDtsgH40KaJqLftwJw==
X-Received: by 2002:a05:6830:4607:b0:6b4:5571:6021 with SMTP id
 ba7-20020a056830460700b006b455716021mr6723389otb.0.1687274863963; 
 Tue, 20 Jun 2023 08:27:43 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h5-20020ac85485000000b003e388264753sm1198802qtq.65.2023.06.20.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:27:43 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:27:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH 12/42] migration-test: Enable back ignore-shared test
Message-ID: <ZJHFbgdyd7yj13rp@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-13-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 09, 2023 at 12:49:13AM +0200, Juan Quintela wrote:
> It failed on aarch64 tcg, lets see if that is still the case.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

According to the history:

https://lore.kernel.org/all/20190305180635.GA3803@work-vm/

It's never enabled, and not sure whether Yury followed it up.  Juan: have
you tried it out on aarch64 before enabling it again?  I assume we rely on
the previous patch but that doesn't even sound like aarch64 specific.  I
worry it'll just keep failing on aarch64.

Copy Yury too.

-- 
Peter Xu


