Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F42247A566F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 02:03:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiOCg-0002Gg-Ap; Mon, 18 Sep 2023 20:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qiOCe-0002GP-Lg
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 20:02:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <juan.quintela@gmail.com>)
 id 1qiOCd-0006hM-2M
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 20:02:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40475103519so47969165e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 17:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695081771; x=1695686571; darn=nongnu.org;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b3/ezFi6DDxQZkm+FA4iXPYYrGUrHpnBRcRIFnle0BY=;
 b=RXTkegMXpCiP+PfjVALIive3CCwZQ6kA3VgIaWsANOQVgN8fM9pVITyKloZCt3Af8O
 Vmh82wLsMz0TpJj31WV/3XBwBYRCFNXfAaC4z76Ymre1TQR0SfxkdTimspDbNpXdLnlg
 UXQxRRjkD92xIio9TL/Xv0lhq2UAh9enKpJh+bjCwkp6w55CjtAvLIy09JUxFAlvDnzl
 l1qdzS/8GbZTW+u7iEsWOipYRLjYi1LYaWhG2UFu/RTs0EMhbc2HZCj1WGvQAGFWOGg/
 Fvozug296OFN2a+j/3WYnzFYlwRKAVU74wHI6lxBMrkC6Swn+SID8wM35p+ck+9woktE
 5ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695081771; x=1695686571;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3/ezFi6DDxQZkm+FA4iXPYYrGUrHpnBRcRIFnle0BY=;
 b=p5R+J3gheGJmYe39lLPRKmrUL2ABKNQBrjN5cwJOAXXT8Zf6myzrF2cIuLYYCeR0Rw
 QfoOMfAwE4l6gjIB34jsLtYAh3dLE8LZ7uTezKXRNrGxBX9GTLzGG1Eg2zf/P5oCtaW0
 6IWGC8dQMcejWCtSfhU8GBvlSuxFxrTvfzW5o3CwqOl0tM8PHpdh8s4VEydXkUVrtQXx
 HoDKBYsPLDDFJCmR4+2VeETP6RC6hMWRKZlpPt4d7FH3qJEXuhRoAm8b9pDfMGokQ2v3
 QG4gsWFqnovz+E9i+vUvj2KvImsbs1khc3tu5add+UHve9RnKRfiTfva8rJqPc7vWcOW
 rEcA==
X-Gm-Message-State: AOJu0YzOvIM/yGo5LnD6XbTz4J04ohAMeAHrNlIBf0IJEhPL0uj3P8lU
 GRlBBGK2hCVpNy2hTC3r+KQ=
X-Google-Smtp-Source: AGHT+IF19PtomAOo2Db30F+XY/jkLxNI7d8pY7EjREQ46lOGsYijHJmRMebSgv1fVnVUKzkQkEf8KA==
X-Received: by 2002:a05:600c:21c1:b0:400:57d1:491b with SMTP id
 x1-20020a05600c21c100b0040057d1491bmr9354530wmj.2.1695081770999; 
 Mon, 18 Sep 2023 17:02:50 -0700 (PDT)
Received: from gmail.com ([160.177.141.223]) by smtp.gmail.com with ESMTPSA id
 u8-20020a5d6ac8000000b003179b3fd837sm13841988wrw.33.2023.09.18.17.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 17:02:50 -0700 (PDT)
From: Juan Quintela <juan.quintela@gmail.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>,  Joao Martins
 <joao.m.martins@oracle.com>,  "mdean@redhat.com" <mdean@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,  "afaerber@suse.de"
 <afaerber@suse.de>,  "bazulay@redhat.com" <bazulay@redhat.com>,
 "bbauman@redhat.com" <bbauman@redhat.com>,  "cw@f00f.org" <cw@f00f.org>,
 "dustin.kirkland@canonical.com" <dustin.kirkland@canonical.com>,
 "eblake@redhat.com" <eblake@redhat.com>,  "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>,  "eric.auger@redhat.com"
 <eric.auger@redhat.com>,  "iggy@theiggy.com" <iggy@theiggy.com>,
 "jan.kiszka@web.de" <jan.kiszka@web.de>,  "jidong.xiao@gmail.com"
 <jidong.xiao@gmail.com>,  "jjherne@linux.vnet.ibm.com"
 <jjherne@linux.vnet.ibm.com>,  "mimu@linux.vnet.ibm.com"
 <mimu@linux.vnet.ibm.com>,  "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>,  "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,  "stefanha@gmail.com"
 <stefanha@gmail.com>,  "imp@bsdimp.com" <imp@bsdimp.com>,  "z.huo@139.com"
 <z.huo@139.com>,  "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,  "cjia@nvidia.com" <cjia@nvidia.com>,
 David Edmondson <david.edmondson@oracle.com>,  Konrad Wilk
 <konrad.wilk@oracle.com>,  Alessandro Di Federico <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>,  "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,  "wei.w.wang@intel.com"
 <wei.w.wang@intel.com>,  "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  Mark Burton <mburton@qti.qualcomm.com>
Subject: Re: Call for agenda for 2023-09-19 QEMU developers call
In-Reply-To: <BYAPR10MB286984E6DDD6D4C2C915CAAE8CFBA@BYAPR10MB2869.namprd10.prod.outlook.com>
 (Elena Ufimtseva's message of "Mon, 18 Sep 2023 19:47:21 +0000")
References: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
 <BYAPR10MB286984E6DDD6D4C2C915CAAE8CFBA@BYAPR10MB2869.namprd10.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 19 Sep 2023 02:02:49 +0200
Message-ID: <87h6nruj12.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=juan.quintela@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: juan.quintela@gmail.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Elena Ufimtseva <elena.ufimtseva@oracle.com> wrote:
> Hello Juan,
>
> Not sure if this is worth its own topic, would be it possible to hear
> the community thoughts on the live migration series review/pull
> progress (atomics, zero page multifd etc.. )? Seems like there are few
> outstanding relevant patches.

Hi

If everybody agrees, can we move this topic to next call?
I am on vacation this week and the next.

I was planning time to "moderate" the call, but preparing for a call
about my topics is going to mean a divorce O:-)

Later, Juan.

PD.  I have had too many problem in the recent past with several things,
     from my test machines to disappear (and configuring new ones taking
     forever), to very bad time with the BOTS.  I expect/hope that
     things are gonig to get better in the near future.

