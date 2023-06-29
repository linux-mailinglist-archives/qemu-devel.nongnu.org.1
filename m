Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9741A742F93
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 23:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEzM8-0002B3-FZ; Thu, 29 Jun 2023 17:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEzM3-0002AY-N2
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 17:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEzM2-0003r6-9p
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 17:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688074745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QOU39sYHGinVeKr14ORh+MApWxQgGr88rfPlWnzbvx0=;
 b=Z/xy2tGN+tqCoUC5o4sh2krOXmDGJRUihP0y3+nqDNljpEwHJaGwJyBBGxXpLZdszQC6s7
 fdpFGvX0bFL87Fa00OHZs7YaWlNbSBykyC+awGfiVxzeM7y1I8Obm8wo1RJQ28UKd0HYkk
 zNl2TTamyAl3tsWNal0BYXwHlLMuiyU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-9mPSCbsvP-auQrDevkEdAA-1; Thu, 29 Jun 2023 17:39:02 -0400
X-MC-Unique: 9mPSCbsvP-auQrDevkEdAA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7672918d8a4so30589085a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 14:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688074741; x=1690666741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOU39sYHGinVeKr14ORh+MApWxQgGr88rfPlWnzbvx0=;
 b=ctd/hlhWCh5uD7NVteXDmurOwMJmWe2hcunFAk2OB5fglWHsyOXU2FUB1VK7fndGbe
 JIAzMJaLNs5wYO7RpQlqov8AsEOt4BiiZeLmo3yonHKXmAQ2n/EhsDXZqE8h1ytP9mlD
 X5tytvMt44EGhgZAgiR45Sed4/XgPe26TmxFIes7NjoeC22+ZSsNd3L57Cahiw9T/7Fh
 M0oJlp/QfKQZZaoDH0v/WzCSGw65gTPipxgmEYSeRsnf+MHTTf9PYenUdOtZ9Vr2H30G
 2CqkqwUOlrKbVdGjROShjGFo3IFFJUYvxaWiPvy63HSYX66Y1/ttTAP8CofFrgZJfZMC
 fv2g==
X-Gm-Message-State: ABy/qLYU456RHsgBZlBHikvGdy7UNGm9HACzUXC/tIkuSbCRrMQKohwD
 huW/gqnCCt2PnVR+ryEsNzy+CQRFiUQux+K9KK13HPtSvC0Vfguq4wk6bpj/GNKDqVwezHslja8
 R6SGTKTVLcdflGF0=
X-Received: by 2002:a05:6214:2aa3:b0:634:cdae:9941 with SMTP id
 js3-20020a0562142aa300b00634cdae9941mr966110qvb.0.1688074741560; 
 Thu, 29 Jun 2023 14:39:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGyA77RPr3CwIY4rcCneDwa7c+1NeWdi8OQQZDA1p9zabqpLyzuw1RhdTgnAPkM4QWLWOlEgw==
X-Received: by 2002:a05:6214:2aa3:b0:634:cdae:9941 with SMTP id
 js3-20020a0562142aa300b00634cdae9941mr966100qvb.0.1688074741308; 
 Thu, 29 Jun 2023 14:39:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z15-20020a0ce98f000000b006300ff90e71sm7369189qvn.122.2023.06.29.14.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 14:39:00 -0700 (PDT)
Date: Thu, 29 Jun 2023 17:38:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V3 2/2] migration: file URI offset
Message-ID: <ZJ358gdjNdxsZsEa@x1n>
References: <1687466251-310524-1-git-send-email-steven.sistare@oracle.com>
 <1687466251-310524-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1687466251-310524-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 22, 2023 at 01:37:31PM -0700, Steve Sistare wrote:
> +static int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> +{
> +    char *option = strstr(filespec, OFFSET_OPTION);
> +    int ret;
> +
> +    if (option) {
> +        *option = 0;
> +        option += sizeof(OFFSET_OPTION) - 1;
> +        ret = qemu_strtosz(option, NULL, offsetp);
> +        if (ret) {
> +            error_setg_errno(errp, ret, "file URI has bad offset %s", option);

Probably "-ret" here.

> +            return -1;
> +        }
> +    }
> +    return 0;
> +}

-- 
Peter Xu


