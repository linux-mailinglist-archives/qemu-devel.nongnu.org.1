Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8D716AE6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:27:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q437R-0001YY-4g; Tue, 30 May 2023 13:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q437P-0001Ub-4E
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q437N-0003IG-Gl
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685467604;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FIlYUBJRJ3Md++yjpfppo0hhxIjtfxORdh4MG0rKq08=;
 b=CPJRbQLSxpvAcoCeb7WYeLXqvkexp26e4PTtAmjrDFLCdVvnA2/5FdzILqQaT0MyNVuaOv
 RwgFOvqN4cxxwaZUauc5fcy2j4eXBdMNHuXgnbhw2kxsz4AGcQ/A11g8oUlQXoLur7Ftjq
 804+yxUB7vceAC1fY3Tw4hC4g69mWu8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-eaCTSfXdP6eF69Js34b_xg-1; Tue, 30 May 2023 13:26:43 -0400
X-MC-Unique: eaCTSfXdP6eF69Js34b_xg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso1926410f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685467602; x=1688059602;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIlYUBJRJ3Md++yjpfppo0hhxIjtfxORdh4MG0rKq08=;
 b=GydSPTIS2zN9uBY+oS/yIlHGmlnYlR3puuOnPi/SGgE3m+EyN+Wp1s23E378trzJx3
 4XYsWjprScc/Vauw0YSBgZehMGZafbp1lDJIvI7kxIj7BWcPvl516684RANJhPFLB88m
 vtJH8ESysOD7y4PqWZtV/PziBwdH+jztnGx5yg2DIdb5R+AqQpXtRDpH88ZnjPXtar8w
 FxRms8JToCgbA46/3qlSMNKG3DWZYG1g9DIhqkPKJbvPGkCm0bRhh5CHnv7HhQ/OmJSf
 sRHvRb0QUPM/Q5eIuOML+4jgZgX4WHe2EmIu+b12TIaueTJOp6rgQjNjHQGTVIznaTxf
 Erqw==
X-Gm-Message-State: AC+VfDyE26uUsyHvfvkgox7wSFm635gOAvd0ySQlJcs2y0kNLTvUYKCX
 icjkrUSVyKIWVJmfh+u6bk5Jzu6ITW/3/rE4K4ln7W8FEGRBL4zTTCvG9AZD7AlA0qwdB2FaSdQ
 R05B1VDFtJ9B+Nyg=
X-Received: by 2002:adf:f404:0:b0:30a:d8df:6800 with SMTP id
 g4-20020adff404000000b0030ad8df6800mr2052301wro.33.1685467602062; 
 Tue, 30 May 2023 10:26:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mt5XG/wxVuTpPqjFtdFGNERYUzmlYaJ/jsXegckm63Sre+QKMcOzmL279C0V9IPdK1kJwMg==
X-Received: by 2002:adf:f404:0:b0:30a:d8df:6800 with SMTP id
 g4-20020adff404000000b0030ad8df6800mr2052293wro.33.1685467601799; 
 Tue, 30 May 2023 10:26:41 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4585000000b0030796e103a1sm4010395wrq.5.2023.05.30.10.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 10:26:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Hailiang Zhang <zhanghailiang@xfusion.com>,  Peter
 Xu <peterx@redhat.com>,  Fam Zheng <fam@euphon.net>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 04/16] qemu-file: Don't call qemu_fflush() for read only
 files
In-Reply-To: <733e16a5-39a3-3807-d951-9029e2be7298@linaro.org> (Richard
 Henderson's message of "Tue, 30 May 2023 10:14:24 -0700")
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-5-quintela@redhat.com>
 <60036a5c-920e-8407-e030-1dbc1008418b@linaro.org>
 <877cspwxxp.fsf@secure.mitica>
 <733e16a5-39a3-3807-d951-9029e2be7298@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 30 May 2023 19:26:40 +0200
Message-ID: <87353dwx0v.fsf@secure.mitica>
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 5/30/23 10:06, Juan Quintela wrote:
>> Richard Henderson <richard.henderson@linaro.org> wrote:
>>> On 5/30/23 05:28, Juan Quintela wrote:
>>>> This was the only caller for read only files.  So change the test for
>>>> an assert in qemu_fflush().
>>>
>>>
>>> Not a fan, as fflush(stdin) is well-defined.
>> I guess you mean this:
>>         For input streams associated with seekable files (e.g., disk
>> files, but
>>         not pipes or terminals), fflush() discards any buffered data  that  has
>>         been fetched from the underlying file, but has not been consumed by the
>>         application.
>
> Yes, in that, importantly, it does not assert.

I can let it do nothing if it makes you feel better.

>> Two things:
>> - Current code just do nothing for imput streams
>> - We only call it from qemu_fclose()
>
> Pardon?  There are nearly 30 calls to qemu_fflush.

None of them in a file that is not open for writting.

>> - If we drop anything from the input stream, migration get broken.
>
> I'm not talking about dropping anything.  Obviously QEMUFile works
> different from stdio, and therefore resetting the file state to that
> of the unbuffered data is not relevant.

Ok, if you feel so strong, I will change the assert() to a check that
does nothing.

Later, Juan.


