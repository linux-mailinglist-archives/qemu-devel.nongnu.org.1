Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 213067DE56C
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 18:37:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyF8a-0006rU-Jf; Wed, 01 Nov 2023 13:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyF8W-0006rH-AE
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 13:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyF8U-0003UW-Tx
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 13:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698860170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3wsLd2Sl9OLIowmlPIgootC9eTSc+1GaUn48hBuhFMg=;
 b=Ha3xKqiEgN4payDML6z6cj9xZpPpVzwQVjC4o5gyHwkx5Cq5sjaniQKxdkRdfo85/RjWot
 a27flCrEmQtaB3LVo2e2vwW10Lz/4CboQrJi9fZhu8mtv7dhIxgy7VQlSftEuskOk4Wa37
 0N8VRW/memapUd7llVG+mGKTRTJGLX8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-6yyxEDhGNUyXV6iMJ-qi2Q-1; Wed, 01 Nov 2023 13:36:06 -0400
X-MC-Unique: 6yyxEDhGNUyXV6iMJ-qi2Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66ffa15d354so230986d6.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 10:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698860165; x=1699464965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wsLd2Sl9OLIowmlPIgootC9eTSc+1GaUn48hBuhFMg=;
 b=Gir3zynd8IckyOFny+9OV/LPkmZGsrGPoiAcvtx/LNw84R3CWlXKqY75e2Gf8g3Ggw
 EmMj8FBrbkvWRzM72iRk3rXHbW5ow+VTos650eDAN3K2UHVKHinKqF1Ir9wGbprgwD7L
 TuhnBbNnoSBmTYyhQRtEJbHmSU9hs+qu2xtbGZ2tNQ6RN1EBomhsS1FYgoD1eNL7xXLI
 XIeXlHhwusyMMUeqPHye/q8pXpqNwxDoWMkw8DdikYkLA+FYwL/ewnICvbzFJ6Kplql8
 p8re221yRNiW0fQXqhbajRN0f9n669fyAnNxEszllAvB4zLoaJt1JctIqzKq7EA50a4F
 16Qg==
X-Gm-Message-State: AOJu0Yw6HKCj94uM/PvKXci+3kFUqIUszF7+v8xTnGEGjfZb0vpYVsV4
 ChzQUddePoaxDoUQY1jhoYVFKfXim7adEG0Nw8V1LmCZGBjT6HMnN0GOJHM9drQZSNDOsUoDZPB
 /s/U+SXwlB/2jX5A=
X-Received: by 2002:a0c:f78c:0:b0:66d:6111:5c5c with SMTP id
 s12-20020a0cf78c000000b0066d61115c5cmr16928140qvn.3.1698860165608; 
 Wed, 01 Nov 2023 10:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBloZijx1gS00N8RcPUbMWXmMZKJ94I3FkZXJNzYb579GeC0JfSYgWsXe2jOw4fke5LlG4jQ==
X-Received: by 2002:a0c:f78c:0:b0:66d:6111:5c5c with SMTP id
 s12-20020a0cf78c000000b0066d61115c5cmr16928124qvn.3.1698860165270; 
 Wed, 01 Nov 2023 10:36:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l3-20020ad44443000000b00674a45499dcsm1649221qvt.88.2023.11.01.10.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 10:36:05 -0700 (PDT)
Date: Wed, 1 Nov 2023 13:35:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 21/29] migration/multifd: Add pages to the receiving
 side
Message-ID: <ZUKMSQEcYlXRej01@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-22-farosas@suse.de> <ZUF7VG+CWvuOEbqD@x1n>
 <87il6mcrf5.fsf@suse.de> <ZUJ01lcAJS1PaAIw@x1n>
 <87msvxfl0f.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msvxfl0f.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 01, 2023 at 02:20:32PM -0300, Fabiano Rosas wrote:
> I wonder if adapting multifd to use a QIOTask for the channels would
> make sense as an intermediary step. Seems simpler and would force us to
> format multifd in more generic terms.

Isn't QIOTask event based, too?

From my previous experience, making it not gcontext based, if we already
have threads, are easier.  But maybe I didn't really get what you meant.

Thanks,

-- 
Peter Xu


