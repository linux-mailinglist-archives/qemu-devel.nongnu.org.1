Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBCB7290C9
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:19:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WO2-0003YY-Cx; Fri, 09 Jun 2023 03:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1q7WNz-0003Y4-Ps
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:18:15 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1q7WNy-0000qV-BE
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:18:15 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51496f57e59so2097504a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686295092; x=1688887092;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=StLA8BOK5oNLanVPU58wiNtnq/LM+BHGXf5QiY4AsbU=;
 b=KYVPZ4fui1aTmdMeRIlmcgbOCJ2+hoKWqz45JMIbiaE/DVnYySJSRz4xQ7Uh6NY9Ay
 t85oFr3JYubSTNvdk0z7Ea5atidk7WlbBX6HJZBjODlCNvQMsxqWt1mGC6mkszKODSX/
 05JypczMslAWTetdD5OcSnF0+7pDHZMPysGGySv2i/CnhCXa67xh5tg03jE+NxPRsixn
 H9u3yktZFaQCIFKf8fCvWMq7BfkG2nCTyhQQYjixTOAR/WOs++AChDHTHNFMUvxdxXpi
 JV2t3KwCo90gvPjFSwkzYgRc9e+yyVwF7iV0/aIAtqD+VDvTmoGN++qgJVWgW4Yn2ErI
 E8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686295092; x=1688887092;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=StLA8BOK5oNLanVPU58wiNtnq/LM+BHGXf5QiY4AsbU=;
 b=e4PS6ihiBOgWYqg8lh+9ikY6gxOrf+xJZpsO9V/R2/cfwv43ZWePguA7YLsjafwvkS
 OaLO5+Dti1jKR4yWXP42UDF4dFHcCQOYKHVrt4w8xo0Oo+jUEwFwDC5PsaxwlIYariWx
 /htCQ1mUMAWQYqc4y++27sxb3Agycre3FZn8uYduvEVlMq9FvEToS/rH1KMeiQLOMAb/
 TigR2rXzxq+t+mg2CV/aGa0e2Hy5r1353GN+yckF8IdBGM8jrU7khotCZdZzSKl+kDXK
 cvSiiS9thUsE+oZuqjJ0h6hJ2bzSSjlVpkT+g4BpUeOTi6srncIOgb4EoL1ZASC1SygM
 lxQA==
X-Gm-Message-State: AC+VfDy3K/b2VwPpv8NRWn/omtywW2Rhq9iL+fsH9Kq6o8CDt15tF92t
 p9/z9xs3eKQ9RVvVruxTudkV9oJp/L2Nhnz8j4M=
X-Google-Smtp-Source: ACHHUZ5FcUbFdAKCxBIeodwZFkZr1Y7j/Q4Jt15bSquLg/GLTFnXbQopGVQuoszLyKdpMuor3wpNIfpaGOBorJsxxBU=
X-Received: by 2002:a17:907:7f9f:b0:94a:845c:3529 with SMTP id
 qk31-20020a1709077f9f00b0094a845c3529mr980093ejc.9.1686295092412; Fri, 09 Jun
 2023 00:18:12 -0700 (PDT)
MIME-Version: 1.0
From: Juan Quintela <juan.quintela@gmail.com>
Date: Fri, 9 Jun 2023 09:18:00 +0200
Message-ID: <CALUyDQ7ifb8Pxk5HntzB_AJHtMXd6N_WupVLoFT7EcgXWgCgiQ@mail.gmail.com>
Subject: Re: QEMU developers fortnightly conference call
To: Juan Quintela <quintela@redhat.com>, felipe@nutanix.com, cw@f00f.org,
 eblake@redhat.com, 
 edgar.iglesias@gmail.com, iggy@theiggy.com, jidong.xiao@gmail.com, 
 peter.maydell@linaro.org, richard.henderson@linaro.org, stefanha@gmail.com, 
 imp@bsdimp.com, zwu.kernel@gmail.com, jgg@nvidia.com, cjia@nvidia.com, 
 konrad.wilk@oracle.com, Alessandro Di Federico <ale@rev.ng>,
 wei.w.wang@intel.com, 
 kvm@vger.kernel.org, Mark Burton <mburton@qti.qualcomm.com>, f4bug@amsat.org, 
 Joao Martins <joao.m.martins@oracle.com>, afaerber@suse.de, bazulay@redhat.com,
 bbauman@redhat.com, dustin.kirkland@canonical.com, eric.auger@redhat.com, 
 jan.kiszka@web.de, jjherne@linux.vnet.ibm.com, mimu@linux.vnet.ibm.com, 
 z.huo@139.com, david.edmondson@oracle.com, elena.ufimtseva@oracle.com, 
 anjo@rev.ng, shameerali.kolothum.thodi@huawei.com, 
 chao.p.peng@linux.intel.com, qemu-devel@nongnu.org
Cc: mdean@redhat.com
Content-Type: multipart/alternative; boundary="000000000000f845ee05fdad2b82"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=juan.quintela@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000f845ee05fdad2b82
Content-Type: text/plain; charset="UTF-8"

Canceled fue yo conflicto witjnKVM Forum.

--000000000000f845ee05fdad2b82
Content-Type: text/html; charset="UTF-8"

<div dir="auto">Canceled fue yo conflicto witjnKVM Forum.</div>

--000000000000f845ee05fdad2b82--

