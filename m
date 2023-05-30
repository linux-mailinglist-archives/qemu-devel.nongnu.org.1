Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8A716A6F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42og-0007Vl-J0; Tue, 30 May 2023 13:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q42oQ-0007Sp-M7
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q42oL-000837-Ib
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685466423;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bH2OK/zPtkZX2JnSuR7bPuOS5C/HaAszzfq18lhJzDA=;
 b=eqo0AnH7OVll6rBGT8ZotcVxXN5H39+BjxZEIKu+6j2GznUTCAneQHlC3UyxiQDl9CTAJI
 zuP8IqVsD8Vb8UjiAFrRkqNKrH0G59FZ7sTJMueetQc+xksNNw8vREhV+LZvK2JP+ONSNH
 xktMUbaMrWziPK+8tbvTahn7gR9dBR0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Q2otuK_SPRimng6At2TnMw-1; Tue, 30 May 2023 13:07:02 -0400
X-MC-Unique: Q2otuK_SPRimng6At2TnMw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f3a9670ae0so2402978e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685466420; x=1688058420;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bH2OK/zPtkZX2JnSuR7bPuOS5C/HaAszzfq18lhJzDA=;
 b=Php+B/OskLUVF+yh2mEMEnbK5Vc72nnhzHtGnxm4KI7BjZja6KyrpfVJDVRW1eDuvT
 SBU6n3fz3UfyyK8aNrvXps1pRrHOOjRRnImU0dXTfgpEGqVG0gqGZ7KUqMYH15jXgKTI
 Tt1Vwx08E6l2+otr4kXqzHp0jo9MHZFm2DWMYDcDGt3lAFsLd0t9VuFaSrj2rq3GRQtb
 v/z3SRXlZjAugkfMiw26p7VdYDREcvzcBRB6eYQ2OswrVXPu7xTVpQ+mNkOu/aIbYOcQ
 3f17WBFmulP0mkgh68upVJPJjR7KPNE3+upE+ereX601dqRgOLVwG0N7usTfMtgJZ3kr
 89WA==
X-Gm-Message-State: AC+VfDxvSbUsvcrDruzqSxtBttsIjVIZOUenkVsQ3ZMJ5+k/IoFaAPBO
 gvmpUDE4HULniec0jGaMJhkG6yUrwEgS3HehQRvkTY97OoWmPKH/g+QntabPfCXY2GElM3mvUxu
 YORuESQjHAOHwYQw=
X-Received: by 2002:ac2:59c4:0:b0:4ec:a18e:f989 with SMTP id
 x4-20020ac259c4000000b004eca18ef989mr1366668lfn.17.1685466420697; 
 Tue, 30 May 2023 10:07:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wBmGknCGYYlo3pNnQVS+LG8N6qHmxMfNYI7lXGTCfgr+INzDhjbtRhn1UqqwHSvXx+5VY7Q==
X-Received: by 2002:ac2:59c4:0:b0:4ec:a18e:f989 with SMTP id
 x4-20020ac259c4000000b004eca18ef989mr1366642lfn.17.1685466420352; 
 Tue, 30 May 2023 10:07:00 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k15-20020a05600c0b4f00b003f611b2aedesm18015784wmr.38.2023.05.30.10.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 10:06:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Hailiang Zhang <zhanghailiang@xfusion.com>,  Peter
 Xu <peterx@redhat.com>,  Fam Zheng <fam@euphon.net>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 04/16] qemu-file: Don't call qemu_fflush() for read only
 files
In-Reply-To: <60036a5c-920e-8407-e030-1dbc1008418b@linaro.org> (Richard
 Henderson's message of "Tue, 30 May 2023 10:01:43 -0700")
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-5-quintela@redhat.com>
 <60036a5c-920e-8407-e030-1dbc1008418b@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 30 May 2023 19:06:58 +0200
Message-ID: <877cspwxxp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 5/30/23 05:28, Juan Quintela wrote:
>> This was the only caller for read only files.  So change the test for
>> an assert in qemu_fflush().
>
>
> Not a fan, as fflush(stdin) is well-defined.

I guess you mean this:

       For input streams associated with seekable files (e.g., disk files, but
       not pipes or terminals), fflush() discards any buffered data  that  has
       been fetched from the underlying file, but has not been consumed by the
       application.

Two things:
- Current code just do nothing for imput streams
- We only call it from qemu_fclose()
- If we drop anything from the input stream, migration get broken.

If it makes you feel better, I can rename the function to
qemu_file_write_buffer() or whatever name your preffer.

Later, Juan.


