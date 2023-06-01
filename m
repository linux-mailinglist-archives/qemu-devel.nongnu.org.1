Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEEA71F00E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 19:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4leF-0004XO-H0; Thu, 01 Jun 2023 12:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4leC-0004XC-HE
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4le9-0003M0-MX
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685638772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtkvaCzmDVTz6S4/Ab4RQx5dPSeXIrXSyBnRIDkboLg=;
 b=EdI1zJqGi2kFOzEqDfKMbJOrRpbCA2f5DrLg8kE1Y6YV5LlUTElHMRR2b/kIu0tGDnafEC
 T/r/T+x/XiPdN8wmC0k14S+e0le4kFfHCmF6snSwYVGyHUqsn7Qf9dv61yBsFsqzhR7XQe
 jHEde2iprokEO9vfRpAvgkBigU9SJL0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-UGwQfFO0OMiYxo5HfyFiGQ-1; Thu, 01 Jun 2023 12:59:31 -0400
X-MC-Unique: UGwQfFO0OMiYxo5HfyFiGQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-626204b0663so2353416d6.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 09:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685638771; x=1688230771;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UtkvaCzmDVTz6S4/Ab4RQx5dPSeXIrXSyBnRIDkboLg=;
 b=LYdQrZiEaH7ZqtmNGnjA5ZUIu5xEv70IdI31KfnrNUuDkQUj2XwGaAmsYuYEYTlH4K
 3KpMVuvMjITr96KR3ThDGa3cTma48yHHd+cFsYBUhSXXz2iK8jYtrcn0qw7JcMRuuzHW
 7mWZem8UzK+WOWYv+ts0xg7C/CfTYE+VD+xNf0HGDBXpMqDXf+aeF2CdcDdEo+qT+lPh
 mL0MIBUMBC+f3SUwF8hdTQ8+y5zD3ZCAKIt9r6lrgMPJq10kaoqDzPvX6MyyZ89V44Bp
 cN5h6fF3ezvvbAgETUBY5+sx/lSa78JemCUC5XEHO5+7df7J+rrFQrBcJAYcFS6tQIEt
 PpdQ==
X-Gm-Message-State: AC+VfDzKlHoMzzTAn1O6VIJFk0lMQGK0G40alYpHZiBOZ3hm7AbPSIJu
 QV/fUmAXm3JO+fWW1XChergtHqXx0tkkltKd4iIWZm3j96vyO/uaNqLK7hNcFLP5mrSevc/k3OF
 ikq7kK1ADzMVdd0M=
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id
 f5-20020a056214076500b005edc96eca4amr6605998qvz.1.1685638770975; 
 Thu, 01 Jun 2023 09:59:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PkAqU/1XUYstnPoMcs73AcrmzvCJe6qADg7zt8g/s9y+B9kPRLzfWiemZOt79z+WHr20e4w==
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id
 f5-20020a056214076500b005edc96eca4amr6605980qvz.1.1685638770660; 
 Thu, 01 Jun 2023 09:59:30 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 s12-20020a05621412cc00b005fe4a301350sm7645972qvv.48.2023.06.01.09.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 09:59:30 -0700 (PDT)
Date: Thu, 1 Jun 2023 12:59:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
Message-ID: <ZHjOcQs6rUy+s9o6@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
 <ZHi5gmd+5pQhDqBF@x1n> <ZHi7xLhUp0+5cay7@redhat.com>
 <ZHi+7bgcHPUisc8d@x1n> <ZHi/beg2UqoEnk/b@redhat.com>
 <ZHjEohiecAsu3ht6@x1n> <ZHjIu+RU51m0bF0q@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHjIu+RU51m0bF0q@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 01, 2023 at 05:35:07PM +0100, Daniel P. Berrangé wrote:
> If non-live the guest won't have dirtied any pages, so I wasn't
> confident there would be sufficient amount of dirty ram to send
> to trigger this. Possibly that's being too paranoid though

I think it makes sense to keep compression tests in white list, as I
mentioned the compressor does have issue with buffer being modified during
compressing.  IIRC we used to hit that, so live test makes sense even for
code path coverage.  See comment in do_compress_ram_page(), and also
34ab9e9743 ("migration: detect compression and decompression errors").

If we want to start doing this, imho we should make it strict and any live
use case needs to be very well justifed or otherwise should be non-live in
the qest, so we don't easily go back to square 1.

I see that in the latest post that part is still missing.  I can do on top
to prepare a patch to document why each use cases need live, and emphasize
that.

-- 
Peter Xu


