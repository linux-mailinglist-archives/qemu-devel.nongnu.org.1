Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FFA7AEA9A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5Ue-0000pG-Sx; Tue, 26 Sep 2023 06:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Uc-0000ok-5M
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:40:38 -0400
Received: from qs51p00im-qukt01080302.me.com ([17.57.155.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ql5Ua-0002OF-BJ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1695724835; bh=6wY7ri5FSF2GcSV6TFemrRUXJ8YthJLsK1oVbhV4jcM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=Ww60ZGN7YyS66lx9MysVcDwgnr5bYFTPmv+rUrHUtXYt0Pfkdv2Z8H4E0e5SRmkwb
 MDk7fu172U00JWZauFIKqGYpzD8cHIAHxWpt5a69FpNtiOyJHehEGuB206igkot/BT
 GhBc8XdjgOTnjB6uTyVYP/aDTJ0FCLDOgVF7AbADafquafU+zNRmUlQYtxz22bCRjs
 qE6Szam4Mat4bngyWKV/h4/mINK2poE742nfrdwqpczUF+L+WR7gPyQn7U+JMtRbwF
 Nf4A5vPY1MHfM8zIecpZ3lmmJVlagdWcrZrTw3EPIdoznCaGpmgRMVsJJlqmOWfBUO
 jB/OWPTa3Yj2g==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com
 [17.57.155.28])
 by qs51p00im-qukt01080302.me.com (Postfix) with ESMTPSA id 189E0114028C;
 Tue, 26 Sep 2023 10:40:33 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 12/14] simpletrace: added simplified Analyzer2 class
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20230920202855.GL1094271@fedora>
Date: Tue, 26 Sep 2023 12:40:22 +0200
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7F98897-13AA-4933-A6AD-B3B3DAF62DD5@ynddal.dk>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-13-mads@ynddal.dk> <20230920202855.GL1094271@fedora>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Proofpoint-GUID: 7ax_F5ZO4OmBzuEn1WWTvpTZ05R0jh8_
X-Proofpoint-ORIG-GUID: 7ax_F5ZO4OmBzuEn1WWTvpTZ05R0jh8_
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1030 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=686 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2309260091
Received-SPF: pass client-ip=17.57.155.21; envelope-from=mads@ynddal.dk;
 helo=qs51p00im-qukt01080302.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


>> +    class Formatter2(Analyzer2):
>=20
> Was this class part of the benchmark? It appears to be unused.
>=20
>> +        def __init__(self):
>> +            self.last_timestamp_ns =3D None
>> +
>> +        def catchall(self, *rec_args, event, timestamp_ns, pid, =
event_id):
>> +            if self.last_timestamp_ns is None:
>> +                self.last_timestamp_ns =3D timestamp_ns
>> +            delta_ns =3D timestamp_ns - self.last_timestamp_ns
>> +            self.last_timestamp_ns =3D timestamp_ns
>> +
>> +            fields =3D [
>> +                f'{name}=3D{r}' if is_string(type) else =
f'{name}=3D0x{r:x}'
>> +                for r, (type, name) in zip(rec_args, event.args)
>> +            ]
>> +            print(f'{event.name} {delta_ns / 1000:0.3f} {pid=3D} ' + =
' '.join(fields))
>> +
>>     try:
>>         run(Formatter())
>>     except SimpleException as e:

It was indeed, but was left in as a usage example. I have decided to =
keep
Formatter2 in favor of Formatter, as Formatter is based on the Analyzer =
class
that this patchset is deprecating.=

